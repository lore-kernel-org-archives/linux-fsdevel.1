Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F08461419A4;
	Sat, 19 Sep 2026 00:13:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789776805; cv=none; b=eAqvUYPKFUi8OKs3beJN79iZDWUMDdFnsBDD/18wud+3CsBQk/b8vN73ENRfiMfmplqkTkDxPL+qndNi1E3w0XuCmqKacniOO2uQCuGNO6YYZDmxN16GUqWvgBU737N+6QY+xT1/s+UXEdCQH0bunpOA7QNhnHdw3tCgmJPyWDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789776805; c=relaxed/simple;
	bh=buyHeG3UJwEPWEU6g8byIvd3wYSdKE6fEpTsElr/UlQ=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=nIhpW2AqfIUPIU+ddcfuJUQTAE9C1sNShTaG2XY5PvVhZB90YqXBXwsYuKcGl45cLbGySW33IQVsM+aHqr8LrlBkudnHJ1SmEHcZrzq0i5VlPTJ4LNz707pHX/jwVT5hvHLCV9lzYR3+PPp4qIXX4BzykISSzfG0NZDWcyiZODA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J7sIrOME; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J7sIrOME"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8DDC81F000FF;
	Sat, 19 Sep 2026 00:13:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789776803;
	bh=2ppZlK0eCWJAiVjrFR6hYO6tChrakKqueSRWUM6kGCM=;
	h=Date:From:To:Cc:Subject:Reply-To;
	b=J7sIrOMEDrUZw+8MgmxFnj51FwCBuEfRap2bXSSckja/UEeleJbIDAYMYWBftqD+H
	 uaZk6QxMdwKdTnRNLdlMP3Ig9HHjHSNWcBl+Q3qRE+85OGcofBVw4X3i+TiVC7YIuz
	 nUBBcRIHPUbueWbGmLhDR/E4xlJHoJCS+yVz8m4Y4wMPt2zZS1bcK7zxlpAqhyEfLf
	 Lma+YDtpinl2sLOypYjt7hLyEHMwJMKueWG+CDDVEx4Q2kdB//JBsJqYIvwHAYAZte
	 PlTqv21tRSQSQVlYVobSUYXDz2F5RnBINaY1FiBg4iJavVBwEeT6BPUR4dok7i+PBM
	 AwRzHSDdWNDdA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 4F071CE00F0; Fri, 18 Sep 2026 17:13:23 -0700 (PDT)
Date: Fri, 18 Sep 2026 17:13:23 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Anna-Maria Behnsen <anna-maria@linutronix.de>,
	Frederic Weisbecker <frederic@kernel.org>,
	Thomas Gleixner <tglx@kernel.org>
Cc: linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>,
	linux-aio@kvack.org, linux-fsdevel@vger.kernel.org,
	io-uring@vger.kernel.org, netdev@vger.kernel.org,
	kernel-team@meta.com
Subject: [PATCH v2] Fix data races on hrtimer_sleeper ->task field
Message-ID: <5dca353c-6b3f-4d01-8808-bef2c0dd7af7@paulmck-laptop>
Reply-To: paulmck@kernel.org
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello!

In CONFIG_KCSAN_STRICT=y mode, KCSAN finds data races on the
hrtimer_sleeper structure's ->task field.  This field is used to indicate
owner of this structure, and also to signal the sleeper that the sleep
is over through use of a store of NULL.

Because access to the ->task field is open-coded across several kernel
subsystems, this series creates accessor functions creatively named
hrtimer_sleeper_task_get() and hrtimer_sleeper_task_set(), and uses
these throughout.

While in the area, also apply READ_ONCE() to lockless loads from
base->running.

A key goal of this and similar serieses is to reduce KCSAN noise in
strict mode so that new data races are more visible.

The series is as follows:

1.	Mark data-racy accesses to hrtimer_sleeper ->task field.

2.	Use accessor for hrtimer_sleeper ->task field.

3.	Use accessor for hrtimer_sleeper ->task field.

4.	Use accessor for hrtimer_sleeper ->task field.

5.	Use accessor for hrtimer_sleeper ->task field in waitwake.c.

6.	Use accessor for hrtimer_sleeper ->task field in sleep_timeout.c.

7.	pktgen: Use accessor for hrtimer_sleeper ->task field.

8.	Use accessor for hrtimer_sleeper ->task field.

9.	Use accessor for hrtimer_sleeper ->task field in requeue.

10.	Update hrtimer_resolution only if value changes.

11.	Mark the hrtimer_sleeper structure's ->task field __private.

12.	Apply READ_ONCE() to lockless base->running loads.

						Thanx, Paul

Changes since RFC v1:

o	Add patch 10 to avoid both cache misses and KCSAN false positives
	when updating hrtimer_resolution.

o	Add patch 11 to mark the hrtimer_sleeper structure's ->task
	field __private, as suggested by Thomas Gleixner.

o	Add patch 12 for a similar KCSAN issue involving lockless
	loads from base->running.

------------------------------------------------------------------------

 b/fs/aio.c                    |    2 +-
 b/include/linux/hrtimer.h     |    8 ++++++++
 b/include/linux/wait.h        |    2 +-
 b/io_uring/rw.c               |    2 +-
 b/kernel/futex/requeue.c      |    2 +-
 b/kernel/futex/waitwake.c     |    8 ++++----
 b/kernel/locking/rtmutex.c    |    2 +-
 b/kernel/time/hrtimer.c       |   14 +++++++-------
 b/kernel/time/sleep_timeout.c |    4 ++--
 b/net/core/pktgen.c           |    4 ++--
 include/linux/hrtimer.h       |    6 +++---
 kernel/time/hrtimer.c         |    9 +++++----
 12 files changed, 36 insertions(+), 27 deletions(-)
