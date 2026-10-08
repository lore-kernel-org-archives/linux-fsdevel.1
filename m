Received: from va-1-114.ptr.blmpb.com (va-1-114.ptr.blmpb.com [209.127.230.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18A533B9D98
	for <linux-fsdevel@vger.kernel.org>; Thu,  8 Oct 2026 12:01:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.127.230.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791460877; cv=none; b=A3Q13qKYeoCzjRklx5zRs1SdwmK3c64vYsNJjqId/AjIMZE0wPIAHiQPvT3QhYKfDcHvkjmcQxCu0plx3jIeXXE7uJ6cGhLbQKvDX8qX8wQV8HNE+tvw7KtejcLgqZv9YIWrJoTso97oSLVtVOjHnYR9t82FBbAPyc1r68KmkGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791460877; c=relaxed/simple;
	bh=eMnKqkD67q/w277RHUhkiQCyf+sEnlojLySsj69se6I=;
	h=From:Date:Mime-Version:In-Reply-To:Cc:Content-Type:Subject:
	 Message-Id:References:To; b=WR1gZwgMW+PSIwubywzYRdkAfD25eZtYRAoGpGsvzZg2un9zI0Ins0PQ+PeHOjtUp58jDk/p+B+56fww1oQyIMqICFFK8/WF/Fq1ZyRgHQM7OXJVon8wpImmVHuUcHQjqSaqd8XxfhkeXqyfGMU+w4s5Et0VzGMwJG+3pRlacyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=Kl8fNskF; arc=none smtp.client-ip=209.127.230.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="Kl8fNskF"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=2212171451; d=bytedance.com; t=1791460870; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=clBE1imQJIMhVXpUcVFRoRZrEKXYtBFchkMe5EhiB7E=;
 b=Kl8fNskFuuGEwCJXVk5J/6V1nDtU/WXTBqS8xErEw5+htYdRXUYSKp9XhCEievhT3E/RXQ
 QGwXlwxb78wiHhU7yqGTvl2qClYFUgxrku39AZdxggAIge2V25Ui2rW/6M0/toNyqsUYFH
 1PGQSxK0ZCYOjv6nbfE3/mOuS0ME7zdzvG9aAiZJHQyUuBsTUiTNrjWlRecxKFfRm2ABNv
 wmTyMogK5NV1u9ARD7Ez13JWIFpED8LGpR7O3kVUCI4ybcra8XRLrZkvJq5r7y7MNGsz56
 2DCl4cgH2jwuedAIUOgeCIVEd30YXYpmDVlH/Dia0NA6QxMdCF4Aw6QG8yzOjg==
From: "Jia Zhu" <zhujia.zj@bytedance.com>
Date: Thu,  8 Oct 2026 20:00:58 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
In-Reply-To: <4467cbj7eivubtdwcawvr7mhrb7armgoc4xfqjjnncrbkxxag6@3mmou6nhviao>
X-Mailer: git-send-email 2.20.1
Cc: "Jia Zhu" <zhujia.zj@bytedance.com>, <amir73il@gmail.com>, 
	<linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [PATCH] fsnotify: avoid unrelated mark reaper waits during group teardown
X-Original-From: Jia Zhu <zhujia.zj@bytedance.com>
Message-Id: <20261008120058.542583-1-zhujia.zj@bytedance.com>
References: <20260909170833.5663-1-zhujia.zj@bytedance.com> <4467cbj7eivubtdwcawvr7mhrb7armgoc4xfqjjnncrbkxxag6@3mmou6nhviao>
Content-Transfer-Encoding: 7bit
X-Lms-Return-Path: <lba+26ac78604+b56276+vger.kernel.org+zhujia.zj@bytedance.com>
To: "Jan Kara" <jack@suse.cz>

On Thu 10-09-26 10:34:09, Jan Kara wrote:
> Yes, but is it really practically relevant? The optimization you add really
> only works in the case when you have no notification marks in a group when
> entering inotify_release(). Usually though you actually want to get
> notified about something and thus do have some notification marks :) and in
> that case fsnotify_clear_marks_by_group() -> fsnotify_put_mark() will add
> marks to the list for the reaper to process. So please explain why this
> corner case practically matters to you.

Fair question. We've been chasing a class of fsnotify hangs in production,
recurring across several kernels, all the same shape: one thread blocked
holding a global fsnotify resource, cascading into unrelated tasks. This patch
tackles one end of that -- skipping the global reaper flush -- but as you say
the refcount==1 skip only helps a genuinely empty group, so it doesn't cover
the common case. Tracing the production reports pointed at the root instead:

inotify delivery holds fsnotify_mark_srcu across the event
kmalloc(GFP_KERNEL_ACCOUNT | __GFP_RETRY_MAYFAIL); under memcg pressure that
allocation sits in direct reclaim (NMI catches it running in
shrink_node/mem_cgroup_iter), so synchronize_srcu() in
fsnotify_mark_destroy_workfn can't complete and the global reaper stalls (D,
327s). SRCU and the reaper being global, the stall isn't confined to that
group: unrelated processes closing an inotify instance on exit all serialize
behind the one reaper in fsnotify_destroy_group -> __flush_work -- in one
report both inotifywait and a systemd process, blocked 327s. So an ordinary
workload writing to watched files under memcg pressure can wedge unrelated
process exits host-wide.

The fix that actually addresses this is to not hold fsnotify_mark_srcu across
that allocation: pin the iter marks, drop SRCU around the delivery, re-acquire
after -- so a delivery sleeping in reclaim no longer holds the reaper. Teardown
still waits on the group's own marks, so ordering holds. Reproducible on stock
upstream by holding an fsnotify_mark_srcu reader and closing an unrelated group.

So I'd send that SRCU-drop as the primary patch; this destroy_group change is
at most a small optimization on top of it, and I'm happy to drop it.

								Jia
