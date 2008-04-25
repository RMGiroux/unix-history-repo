/*
 * CDDL HEADER START
 *
 * The contents of this file are subject to the terms of the
 * Common Development and Distribution License (the "License").
 * You may not use this file except in compliance with the License.
 *
 * You can obtain a copy of the license at usr/src/OPENSOLARIS.LICENSE
 * or http://www.opensolaris.org/os/licensing.
 * See the License for the specific language governing permissions
 * and limitations under the License.
 *
 * When distributing Covered Code, include this CDDL HEADER in each
 * file and include the License file at usr/src/OPENSOLARIS.LICENSE.
 * If applicable, add the following below this CDDL HEADER, with the
 * fields enclosed by brackets "[]" replaced with your own identifying
 * information: Portions Copyright [yyyy] [name of copyright owner]
 *
 * CDDL HEADER END
 */

/*
 * Copyright 2006 Sun Microsystems, Inc.  All rights reserved.
 * Use is subject to license terms.
 */


#pragma	ident	"%Z%%M%	%I%	%E% SMI"


/*
 * ASSERTION:
 *	The argument to clear() must be an aggregation.
 *
 * SECTION: Aggregations/Clearing aggregations
 *
 *
 */

#pragma D option quiet
#pragma D option aggrate=10ms
#pragma D option switchrate=10ms

BEGIN
{
	i = 0;
	start = timestamp;
}

tick-100ms
/i < 20/
{
	@func[i%5] = sum(i * 100);
	i++;
}

tick-100ms
/i == 10/
{
	printf("Aggregation data before clear():\n");
	printa(@func);

	clear(count());

	printf("Aggregation data after clear():\n");
	printa(@func);
	i++;
}

tick-100ms
/i == 20/
{
	printf("Final aggregation data:\n");
	printa(@func);

	exit(0);
}
