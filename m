Received: from mail-dy1-f174.google.com (mail-dy1-f174.google.com [74.125.82.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5FA2381E9D
	for <linux-fsdevel@vger.kernel.org>; Fri,  2 Oct 2026 19:49:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790970542; cv=none; b=fnex8+DbOgPhG2p1H+DMAHhhY9UNjWysn/aesbruShvvcGR/wA3okBcPajqQf76VaxrJl2CPnOZI6Wpg5vdLaaDCOegZIM/mAIiGHiVkIv87AhnI7lPJWvfUth/S+X+vYyll7g8oYRbcdr4SrWfL+UEA2g03ZZhxzN3crUkeaMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790970542; c=relaxed/simple;
	bh=wAl+qdbi9Hd22fVYGapW9N/anjAnts3gRcz/GkPO/ms=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=nBvS4KMT5E3Xdz8OziWo2o6Ci4Cr7mIB6OlMcnSOV3U3f1KpcR5GZPM+9a0gaBbmArV6/lqsR7VgCzt3Xvfm5aotyeVxxQcbiT9KwtaO+MQVL4g4u3RR40OJrmFWSP34aiURa3VaMmOY5pgTY37KHPJDthSRrEu5dctapT5E0e0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pX4xUDqk; arc=none smtp.client-ip=74.125.82.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pX4xUDqk"
Received: by mail-dy1-f174.google.com with SMTP id 5a478bee46e88-34bb8b31647so411333eec.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 02 Oct 2026 12:49:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790970540; x=1791575340; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=P6e/dNPfrx7m6vbRBSm96K2MYOgE26eXshzUHFi8NIk=;
        b=pX4xUDqkkmEgewcuZiHVfQ4mNqs+uGpdjOUBCxSgjKd1trQzSbgf4sSFmse/e0QMGt
         mM8IHCCZw2QwXG7kG9QOfvbVKm8APW4QpxPTjT7QL4aWVljZwWgCv3+kpJQJq7/v+jlm
         eV0Pujw+fIsbWprr9lJ6AUNiDykgE3iRvK9R8KTZ6qWhurVHmxohY/ioH+jcc/So69ne
         O9kGjb//WLKVa/iITqJnH0xaslV4ZmkWuVMYTYTn/TRbKUPueRoVYIonHvMd1iQ8ZGuo
         wko6PrxtFeSBx0EoTScK5/YN6EprY1UuYCt4/jgITifLPwxdHUUFauVOA/SoHoSnNpn8
         CcRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790970540; x=1791575340;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=P6e/dNPfrx7m6vbRBSm96K2MYOgE26eXshzUHFi8NIk=;
        b=JvPSpe9bMPkIZ0AltsSkNM0NvDAKGb4VoxTCZOONMNUsFbCgLsqKZwqXLCa694Kwmo
         oayNC3Udxbc2eYRAgtOBMiMZs7HO8zXxuVz292OLIbddbl5ov0caLK4sKfEX/67EZQlu
         LBhkZp5Le1wQtn6FHwGfoafzClm934kvyk3j6zXkAbtjeZWts4S3KU0OpGi7o0Wpzwxx
         0vFb31XLCv6+s9ncQ1MajLOTOpTDsJEcHYafZ1KXUMGzc8mr+uhJKdQ3LtHvFZsnSTeP
         6IJenK5ADG0wojJvBpbHEhqKq2sjTBIP0/BifCwv4iWxMoh3tc5BVk93Xx+NjoEh4CkD
         oy2g==
X-Forwarded-Encrypted: i=1; AKwUvBw/MYga7ZtJPfzVk3ykFyjs0d7sKromD+TKGnJfbcVHHPf1XTZno4tJ1vesQH2ADYJqyssJeVTGYWrW5puh@vger.kernel.org
X-Gm-Message-State: AFq9FYKNX/SyXa+vXWf3Qku9i+ks+dtr+4bT8JbWGxRJarfzAioiB8mY
	iW4R+FHJzgjhSmNV0yJrAp3xlfotDcinFMaOTRjQzU15NCKuXm6N9RB3
X-Gm-Gg: AYBFou3r0bElxCmQHNz13YK4vJLHI2wa6vTayLDeF0EOqKA3fEU0fzrl7OF2FvyICOF
	n81aueX2Abpe9xVQD7AqlWaweqV5BNIbAJBgoxZ5/xmVs2Yq+HY1JVhaTHKLcMiISXG9qWU3IJQ
	NrlrRFLi9AaGBWQtyZpZQYnnKsoABiBXSge0OsfvzkNzL0I+Can+7t3aneOjoebdBV2PwgtLvUL
	HLyFJtwnBGqOyD6y/DEMbFq3nCTNoO9XyRPbEs92VsMbCKzP77ZuOrVQpJiW0gjzhqIhdJeXWd6
	Gcu9AMOXy+alTEuVZriYl+bOhxtBlGGpRCo+Tf5rOyq4/pAyBBtXkjS5tGdOVXaiIGiwsPN+7Wj
	N6OVGFAJ/0ojYBat/4Rj4weprXT6x73DOdpu/bFmFDs1JRbJv2CPvkKzYcvti/lmIvuIW/J6Kfs
	JRxMCybKZzMciEBt0YwVjoHbWtRP+vh2X//4a3pd7slGdTn/VB4LSJRRCl3MPYVRXqzRkOczHOf
	s0zcfH8zfRBXxgw4x5aRd4=
X-Received: by 2002:a05:693c:8508:b0:350:4fc1:f22a with SMTP id 5a478bee46e88-3511147a7femr742331eec.21.1790970538687;
        Fri, 02 Oct 2026 12:48:58 -0700 (PDT)
Received: from csl-conti-dell7858.ntu.edu.sg ([155.69.195.57])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-34f14f9f2afsm18930911eec.18.2026.10.02.12.48.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Oct 2026 12:48:58 -0700 (PDT)
From: Maoyi Xie <maoyixie.tju@gmail.com>
To: Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>
Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>,
	Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	K Prateek Nayak <kprateek.nayak@amd.com>,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: sched/numa: Ngid is reported as a global pid inside a pid namespace
Date: Sat,  3 Oct 2026 03:48:33 +0800
Message-Id: <20261002194833.1069966-1-maoyixie.tju@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi all,

I think Ngid in /proc/<pid>/status is not translated into the pid
namespace of the procfs instance it is read from. I would appreciate it
if you could take a look.

task_state() translates the other pids it prints (fs/proc/array.c).

	ppid = task_ppid_nr_ns(p, ns);
	tgid = task_tgid_nr_ns(p, ns);
	ngid = task_numa_group_id(p);

task_numa_group_id() returns the gid of the task's NUMA group.
task_numa_group() sets it from p->pid when it creates the group. A task
in a group therefore shows the pid, in the initial pid namespace, of the
task that created the group.

A CodeQL check for pids printed without a namespace translation reported
sched_show_numa(), which prints the same value in /proc/<pid>/sched. I
reproduced the Ngid case on mainline 5e0f8396d480 in qemu with two NUMA
nodes and numa_balancing enabled. It needed no kernel changes. An
unprivileged workload under "unshare -Urpf --propagation private
--mount-proc" has tasks 1 to 17 in its new namespace and reads
"Ngid: 421" from /proc/self/task/<tid>/status.

I sent these three fixes for the same kind of gap this year.

  keys      https://git.kernel.org/linus/0d6a4268b060
  io_uring  https://git.kernel.org/linus/3799c2570982
  netdev    https://git.kernel.org/linus/1f24c0d01db2

I am not sure which fix is right. One is to keep a struct pid in the
group and print it with pid_nr_ns(). Another is to print 0 unless the
procfs instance belongs to the initial pid namespace. I tested the
second one for Ngid, but proc.rst documents 0 as no group.

Does this look worth fixing? If it does, I am happy to send a patch, or
to leave the fix to you.

Thanks,
Maoyi
