Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.50
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795774452;
	b=ZXiAkXyaYj8HKqT6gNULCOCkcsjSWsvFsXolxbUp6cFNmIZlgN6hGO7guRNVBPZetDZ/
	 o+rW2Nd/2Bz2IReZW1U12fJhpZBjYroIIjqcIB8g3kIL88cLc1ApKO/bgdzUEqvSa15Tw
	 yxnpzii7P3l//VI8psUpPOCjwVMRatpOHrvzs5R45APoJNY23eadwPQLFKhiWupYn68hs
	 LmXtqe6NCMlkHRQCK/NbXOH1Z6dgeuI4UM+xZ6sJxSLkFSEK7sTqUo4HjtTWd8E3HtoDJ
	 TY3JyZuy0H9/PCwBfMuk7dF2Xcjlkpi1Dvcxvjg9Q/VkyKD+2naOE0xmZLYfuFBM1VQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795774452;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type;
	bh=pnSZi82mVfZLS6PwIZVcWPzE7AlvW48La+q7lJF7NRc=;
	b=4kUjt6oVcs6jc5DvJn005C7jKKAOYehL1aLrjdWyIlnfrX914YuvETKq/oMayPj1wGFU
	 wlmKGvurQA8hxPXTZeefSv6KF8xHucivHTAUjzKL5BkvOOCHP6ZKZ1C8IdfZytOMoalf+
	 T4QrCn2WcMof7Yi/8wm4ZrEHB9gxjFNLPlBRS1MK5lPZQ8XnqXJP2nAMiIXNzu+4vH09O
	 LAkrMgMJrQGc7oIcRrlajv+QckH9DrJfqkpYRxfehtB6XbrJzlED24bEu7CU+fR1a790x
	 fDfYZpfIHJLYEvkqv9dykxqFP0Zc7Rmy6elgcVMYY8ouR9atd1MYOyAVDz0n2QdMIiw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=YDGzarso;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.50
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BFE060A2617
	for <linux-fsdevel@vger.kernel.org>; Fri, 27 Nov 2026 10:14:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0BFE060A2617
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=YDGzarso
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-6b87408c797so2004767a12.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 27 Nov 2026 02:14:11 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795774450; cv=none;
        d=google.com; s=arc-20260327;
        b=mLu4UFtDWEpKh7u8f2LxfhggUJpv2BiQWlYcAN9mqdVMNGqqzSAxf5AtopFWMCurGL
         aHdoKfeRW7+F3EcVLb78SBlA5jiC9wWgMj3LpvbTD8vzomvMB8PEZiWKKnYGGQ+s6S75
         SyiQOlVfdJn7sG3jq87KpXa+tlYHxns4Tf6l9tgbS9mYCEjMpvHxH+jBCvFOFlGa/WXn
         Zep/iXakBW0JhPI8OAraHf/nPeMCz2Qz58IxBK0iSLC3ZTaYvrXTGkInj9x6By7bNY6K
         ymAAa88e/DuYN1bUB0XXw6Cm3r70vapAW52gmwkhSX2ngzILFxkI4RttkrTR6FnAXFLi
         0VqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=pnSZi82mVfZLS6PwIZVcWPzE7AlvW48La+q7lJF7NRc=;
        fh=h7a3ieOCIfsDkewaschEgwVSAYTabpObQzyC49WCE4g=;
        b=WbzCl1bbOD8JryzXZlfjOa2g2nQie4eOwrm3MyuASXVO08F3PVPX4gDT0V13r2eAKB
         Xw5d3+xRFxn+Bnc+VhXvIMwruqtR0yhLZ3pbBfabpjO8omVWAAS9UMFZ1yuV3romVwnz
         rLLXmr+YCQ9bX2JOHmLnVcFwhlvV48gKlQXeqqaMeyyJXUZEgS50bop3X7LyZSpuG5lz
         FYdw0Yyl/RrBfy+xj4C+JW+3lxUmqZHKucvNy2WCegz0vlxsm8EF8ykQGc7yu91StjXP
         3mmCCvtFpB0igqIW9JyFwiQiPsjCm82G/wtwEGEpw8wHLODrJRIqxGxoY7fQvE4BtJpC
         TCYQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795774450; x=1796379250; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:mime-version:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=pnSZi82mVfZLS6PwIZVcWPzE7AlvW48La+q7lJF7NRc=;
        b=YDGzarsoRdrYESd0WQH9jBHguYTwQ4MWdevK+E8KmC2uyYZLyscJgJwBjwonhC0NwT
         Bpl0R8s2k8kM3FuRv9FJf/wNwnI4Fc8/M8oqwnbMB+SuPWfh5FQpVSPenWXXWhy0LSkG
         sihB80deO7zB26y3FM3Qxo63SaGHV4Hlk0xud2yxHvlJcFdpP2r7KfcKkQcS7J5mMOIk
         yNq+7yigz9q0FaWoAyhrYX8dVr28Zsxpht995AvRZ0JNonpCR15863AMxYKEzaVj9BIN
         ZE+9pctjIYTqfK5r0M9n6Op5Mo20Hpx0XYCb1SgrrnlTiDwGGAuSqSE2STS7RkRnUD6U
         JwxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795774450; x=1796379250;
        h=content-type:cc:to:subject:message-id:date:from:mime-version
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=pnSZi82mVfZLS6PwIZVcWPzE7AlvW48La+q7lJF7NRc=;
        b=NWjivLBjWTK1JpOfD1XuGc/BjTAXz/TclcoU2BBF71ak4fc9azgcE40L+fD/GwTgT3
         aFOmBRGwF2iXp20qiGI0lYiYF6dqu7wdMxwJtF3d/45ZlTPzNcwACGd0zdWcom71MvdC
         3mFbFjDooH5n7UtFQKboIfBicKT19+7ndACO+Eeeo230/Q9bV/qf+ScxgSxdknZLN68z
         x+oCztbt0PPoGb77ENibhi3MB5IIiqGeAtrYBshHijLWJTILee7TpGNPDc28b6k2AecU
         Gnc0g1s+WHI215NsRLJxZ9PpLFkocr6VP4lSNQk0EaFYPrUJTNbSgokDMORylJLJR+mQ
         zhug==
X-Forwarded-Encrypted: i=1; AL+hErF6Al1zfpVjy2qw+3WQNsdpAIn3cupUR0fUqC2XfBuKJOMKboOoGgA6dvMbBkukl+9QUzgatFREQFg9S9mP@vger.kernel.org
X-Gm-Message-State: APuU4Z88fuXdgn08UB+ZIjuAZHBpOclWHSfH5pYIeBfFmzAL/dr07lp3
	kaKV0fpvNkysJF3vtnRBihopNIeHg82NnHHOkJkWxOIvqmsRNBNy2Sw67gDpAEC3UqXE7I1THbP
	d350O5FczVZ+BvQFCn8W1dmO68cbu0wI=
X-Gm-Gg: AZFdTZeDTLmEaJu2oHIOMm6VjpUYCAo79fASFgPR5sNl6i6Uctk8h+Wgf5qg3zop6g5
	C2HSAK37r4iZFCjnkPA3c5bWb7KWvnR5gZ5WCKSFgow2bzt9tpo68fT7dDZZF1OwSoykYRK9FV/
	4MWqLCiQ8Ls40wGpYi49mTg1He1g1E+mwZmIcXQVIYOXXIzmgoEaSu7rBhqS/Ut/10+VIKUKPyU
	LIHxLhOWJylXhOi1Trqx77pHfo3eyObZ7hh8cktin/3txKO6730LZKKZjgEcXC7FDz3rLKrWNXE
	jKtPrGF45Ft1t6tJbl8ZbaCA8ZMVOBfPUoAKNAOlKgfLs/nLT2p0A7ya0udr8EEnLvrNb/Ij6Kz
	O+ctX3VcWR9tDSBlwCj3k/K3/8khzuUjeSbOPLQldbYy/Cj9JOGQMI+GDQuUf/GyMbATv5c5d+Z
	sqbn/qkeOEDA6t72IG
X-Received: by 2002:a05:6402:44d2:b0:6b4:5d8c:95e2 with SMTP id
 4fb4d7f45d1cf-6ba37c7a0dfmr13780450a12.4.1795774450046; Fri, 27 Nov 2026
 02:14:10 -0800 (PST)
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
From: Abhishek Khade <abhishekkhade69@gmail.com>
Date: Fri, 27 Nov 2026 15:43:32 +0530
X-Gm-Features: Aa3M54oFJndZgHbtbGYTQ8JLkfWXcGRfcl4DQYm07uiwGxgi46GejzDgXxTGmzU
Message-ID: <CANspbQrVUG8h5ZWBW6croG=+VnDoseeJvPwid=gYazA4aKRjOQ@mail.gmail.com>
Subject: [RFC] bpf: Is an open-coded bpf_iter_mount kfunc wanted?
To: bpf@vger.kernel.org, linux-fsdevel@vger.kernel.org
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, 
	brauner@kernel.org, viro@zeniv.linux.org.uk, jack@suse.cz, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi all,

Before writing any code, I wanted to check if there is interest in an
open-coded BPF iterator for struct mnt_namespace mounts
(bpf_iter_mount_{new,next,destroy}).

I tested doing this without a kfunc in a BPF program first:
- Using bpf_probe_read_kernel() + bpf_for(), a BPF program can walk
  ns->mounts (rb_node) and read scalar fields like mnt_id and
  mnt_flags, though without namespace_sem protection.
- However, pointers obtained via bpf_probe_read_kernel() become
  untrusted scalars, so the verifier rejects passing them to VFS kfuncs
  such as bpf_path_d_path() or bpf_get_dentry_xattr().

If an open-coded sleepable iterator (taking namespace_sem during step
lookup and returning a trusted struct vfsmount * or struct path) would
be useful for BPF LSM / tracing use cases, I would be happy to work on
an RFC patch and selftests. If bpf_probe_read_kernel() or userspace
listmount() is preferred instead, please let me know.

Thanks,
Abhishek Khade
