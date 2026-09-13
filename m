Received: from mail-lf2-f12.google.com (mail-lf2-f12.google.com [74.125.229.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D2BC3EDE7C
	for <linux-fsdevel@vger.kernel.org>; Sun, 13 Sep 2026 14:43:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.229.204
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789310601; cv=pass; b=mvYYJic74vgzZhOnelyMRlz782U+dTRnAN8zKt3ZX8NSEvQgySgoMQmI/StMJS0NYkp49BcJS3cUV8Yd2LfbEByLhTjcYXJDbEAtLoAZpJZm2Tc3J4G41YO6pZYhhXkreukDIn+ZoCUKi2CP0xhGCoQYyzyRRSHm/02vtkoN26A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789310601; c=relaxed/simple;
	bh=s50I1f+RlATnyS7ncxttVC4STee39n4jtfw1TIV5Yo8=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=ps19FSCw82rm3VcUjJLv1dS4mAFoxvdv+VE0gNNKdsagCvHYqSf/noYAFfjPntEXFaWQXZAFJ0Yra9uI9snibFZGVYf4yZgc24l4VxVeQzmw8Wg6EBtOq3vy0wLVb+I9VXkWTRTXUEwhrSI+O69qmRQmjhI/LDi7G74zcwb42e8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ifO2WhRh; arc=pass smtp.client-ip=74.125.229.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ifO2WhRh"
Received: by mail-lf2-f12.google.com with SMTP id 2adb3069b0e04-5b79784a6edso1140806e87.1
        for <linux-fsdevel@vger.kernel.org>; Sun, 13 Sep 2026 07:43:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789310597; cv=none;
        d=google.com; s=arc-20260327;
        b=lXoK4BaeokuZv57MMRBWGCLHFlBE5D7/HT1uMYmygNxkqwzLgg2gucZEYZaetvhmlZ
         xpCzri/8npGTmLk6hPJBrcmjdJ1rvjTqwPH10bBv63EBkx0Th4psD+xdD5S5E/pzEiu6
         rkGdm4EdRiDXg0DjUnVuP/zvbE4vFLvapQgXF0Vb1jNJUeHv8uQi+g0wHZBAZzkSZctL
         C/56bMnL6IhZyCUtGwvMD9G1m9Z8mLRLvpluPRe5P/er3Lc5QQ21wKEcFcxtEg7IvTPy
         2rdnXk7vuyq1uX9BXnHFdR6KzpaA3aAe88BMrS47i9/lRNT4vYSG0ljp6JUgbD9qgNIR
         gjhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=gDlSeCeZClgynUnsugyjmVlBCsPDuPwIPykfDcGyfzM=;
        fh=SE68auvbvuCuglcKE/81rzH0vI9INmpj3g/c6Hs29XY=;
        b=bHcY48E1tN+DdMdtxhnL70WhUfUh8hhW80PYT8bWlNkBCmwpNcDEjAta0CAWEUa0nH
         zoqAbOsgrOBACsGp/URxAgrJPUvJb2d7WHxU9I2lrpJzGbZg+KoDqhqebsb5PdK//8DA
         KFPICtp4AAo1TlX/qS+F8AJ8Z9vZvonLmcSa2qBqHHoJhQAD0RyVGk4OjKMcjRr9v4Eu
         N8AQ2l3/60wMKZRGAQUj2UEPliqU4Ny7vKa4L97nrOU9Qd5m8idCSlYrXfwZUMX2jpD/
         oC8s56COtOzWsgS0FqzkD3TWlFlHYqOfXsTl3UvE3Tuzb4f35PcbMo59DAK0e+96tQt0
         MCqQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789310597; x=1789915397; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:mime-version:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=gDlSeCeZClgynUnsugyjmVlBCsPDuPwIPykfDcGyfzM=;
        b=ifO2WhRhrXtDIb73mPmQdy4A6RBD1E89fcx/jvL0anBmS9lzobQGuGU3yN7qqxVhlz
         4BfYnvUCMnwvUzhnBxY2K5l0eyPu+nt/1/AKJ2vBSP3V7QykXJCSt+SDZ5Mhnp20CkgY
         MkEZAJVXlvyL2n6k8/aHehRmw36bT2IZDUeYGIyeb9Rc/8k8JMPtX5VNqsuOr3DqNW1U
         4DZvdtzxgtO8WLDgj9aGPQcWduY7nd1Nw3087KVNT9hdaszy7xouOeX0qNaNthpW7Kly
         mHQ27wZt3FeTifvO3vFqF2hy0w2pLbNZi202kY3+ZQbyRbSTn5fdnzO+I2px2/TqvPf/
         ZCYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789310597; x=1789915397;
        h=content-type:cc:to:subject:message-id:date:from:mime-version
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=gDlSeCeZClgynUnsugyjmVlBCsPDuPwIPykfDcGyfzM=;
        b=smp2kgNp+pIiZHfQfoJ+UfPq+bV2ZjDa0K/O4NyePKLMcs+UURuoTH6le1AQ/WgK2b
         DAKxI+IeFaDnVYekfwqwgvO5rwokuaBb/cdSIB2N30bOU1e85x9n4DEsetACLsLzSYOU
         5EBI3/eCEczJwQDKCQlvZHZLCAbdxoyhcujAliJ0VVZOCXQx6TNgDHrtEvXSWoXLt9Gs
         1qyu792PqKDmi7JxS+GdYDKHi0p2VrZEFxc6XK1ugjq8+XrEge0SvmKlbEuCNarcfbOy
         Nvhov0sNBrzdF+ToAJu6xbVb82CjfePEs/UPIQfCMsvOBQj703FriHz0ph7h0vaw/0re
         tQ4g==
X-Forwarded-Encrypted: i=1; AKwUvBzWKxnr/El9jyX6vLSXRrLFlZ4fzb8I7/9tMvhVMekhA7YVWEi7P4kaIV+dnGWIKkJPzHuyQZfkzSGvYbT1@vger.kernel.org
X-Gm-Message-State: AFuF++ngKBJQxwxba1vx5e6D0HmeZMWucWLoE87vUtL9iYkVp5pEr9IC
	WiG0GKTPLDipM1+cW72y2cBapPFRmRw2gq+AXtLVQF+1s/j2DgDfjz/pxKE3TsdXI6cgtcHoZqT
	lvW+ZdW4QOHXj4zK63PmtjS7k01CjIoE=
X-Gm-Gg: AYBFou3TfrAFjLmSJtTrT7x9ddQeG9exo8TVzFYN4PthIc4z0hUEGPfbQrbkSAZpfx6
	nV+Z8Ve+3zXrVHi4NFWgAv56I9Yd94BVZ5KTsQm2xIN6wm2+CJKACqXBJdO9IxtRKdl2rpqevAw
	IVgjpnzYFuPK8fsFq2YAe6+TDiKiNP+C1qwfodidFRWIQkY+ET/J1l13d8D3giWqzk0aCguEz8c
	hvmOcSHdsoADfP0eJE/YyOzYVxQon/xswF4ju/3StMEV42ezVcFtcXYLhkVX0evxtgldXP353Uw
	0VWrChPcgivKoKRVU9rd+UjB1+bzwJ17WwUjmgraLpUTWQ7dFdb3uDJYQGmxFZQcNMD5h749zfX
	5gsIGSlR5Q2226xc=
X-Received: by 2002:a05:6512:108c:b0:5b7:6682:17b8 with SMTP id
 2adb3069b0e04-5b8a8ef6a7fmr1282624e87.37.1789310596997; Sun, 13 Sep 2026
 07:43:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Chengfeng Lin <lin2530632123@gmail.com>
Date: Sun, 13 Sep 2026 22:43:04 +0800
X-Gm-Features: AcwNN1X5pmsda_UiZ5ntCUgJCNHKWL9vQ4K7aO1nbiEQVANFLK5Pbt5CxzkS2Uk
Message-ID: <CANGjgdn=H50AaA-+O_GA-hkE9UwLANmkjx1zRsKUzxF5za8VfQ@mail.gmail.com>
Subject: [REGRESSION] kernfs: empty cgroup rmdir latency after
 delete-notification changes
To: "T.J. Mercier" <tjmercier@google.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Tejun Heo <tj@kernel.org>, Jan Kara <jack@suse.cz>, 
	driver-core@lists.linux.dev, cgroups@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	regressions@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

Hi T.J.,

I found an increase in empty cgroup removal latency across 507d8ce13f5b
("kernfs: Don't set_nlink for directories being removed") and eea5d2bb34ba
("kernfs: Send IN_DELETE_SELF and IN_IGNORED"). With sched_ext disabled,
rmdir() went from about 6.5 us to 9.6 us, an increase of 46-47%.
The result held in two independent runs.

The workload creates an empty cgroup v2 leaf under a private parent with
the CPU controller enabled, checks it with stat(), and removes it. It
places no tasks in the leaf and does not register any inotify watches.
I time mkdir() and rmdir() separately; stat() is outside both timed regions.

These are consecutive source states, not different release kernels:

  base:   f917dc56060a, before both changes
  guard:  507d8ce13f5b, the nlink race protection
  notify: eea5d2bb34ba, plus the deletion notifications

For the second run with sched_ext disabled, the medians of the nine
sample means per boot were:

                         boot A       boot B
  base                    6.504        6.528 us/rmdir
  guard                   6.956        6.922 us/rmdir
  notify                  9.553        9.558 us/rmdir

The first change added 6.05-6.95%; the second added a further 37.33-38.08%.
Each run used fresh boots in base-A/guard-A/notify-A/notify-B/guard-B/base-B
order. Each point had nine samples of 128 removals, after 16 warmups.
I used an i7-12700KF, CPU0, full preemption, the performance governor and
Turbo disabled. These three kernels used the same toolchain and configuration,
apart from LOCALVERSION. I used the same control binary throughout.
Removal sample CV stayed below 3%, and endpoint drift stayed below 2%.
The result also held after dropping the first sample.
A similar slowdown was also observed with sched_ext enabled, both with
and without cgroup callbacks.

Separate, untimed traces showed 26 kernfs nodes removed per leaf. The
guard change doubled the attribute write-lock entries from 26 to 52.
The notify change added 26 inode lookups. A return-value probe found one
directory inode and 25 NULL results. These counts do not show how much
time each step costs, or that a lookup returning NULL can safely be skipped.

I understand that the notifications and race protection are needed.
A local root-reuse prototype saved about 4-5%, but did not recover most
of the increase; it is not a complete fix.

A separate v7.2-A / 2f0c1cf72f46 (7.3-rc2) / v7.2-B check gave
9.919 / 9.719 / 9.953 us/rmdir with the same control binary. Mainline was
2.02-2.36% faster, with sample CV below 0.75% and old-end drift of 0.35%.
Both versions still removed 26 nodes and made 26 inode lookups per leaf.
The later name-hash change was on the measured path, but this comparison
does not isolate its effect or repeat the exact-commit test above.

Results, configuration identities and the tested workload:
https://github.com/lcf0399/linux-regression-evidence/tree/b1eef2a0fb18babbf8e0d5832b63a655bfd28926/kernfs-empty-cgroup-removal

Do you see a safe way to reduce this per-node removal work while keeping
the notification and race fixes?

Thanks,
Chengfeng
