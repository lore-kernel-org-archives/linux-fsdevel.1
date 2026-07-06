Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E87D2EEE85
	for <linux-fsdevel@vger.kernel.org>; Mon,  6 Jul 2026 17:07:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783357660; cv=none; b=ehCfFZBdS8YLxMu7UaOl4LCky9s/YSkJ7EO9wi0l1wD4Oh32r7ouN7s4A+ya9jUJbPv2ICsyMJXI/33C4NKbRlBMcZpGbpoSrsY3/F7ya7ZoXH60FL0F7GJwQmV85fhmEJpvLrGyrEtYm4AYySvTVBPR36JxeWAvLYcEhTf4nzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783357660; c=relaxed/simple;
	bh=La52E/eiMRqbkoa9U+7aHtBFszAa88Y67rC6/ILJHpg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GQuEbKp5vDrHCmszAXzm1mqYsqWPRhgi2ubiDnSYNQtDaWqIzWIuQvKkqJqM/aBI2dasB08HSyAFZXVo76FXIywpp5tFuDiYwjCIuoHn3dkdhWV0AFKndjMoVLdFDkM3drvevVoQPDEfcIN/EAHuLUkUYQ5eKRrXyKK9+sHIgM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KXP9DNGK; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KXP9DNGK"
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-5aeb89359a3so2613334e87.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 06 Jul 2026 10:07:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783357657; x=1783962457; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=bTKln45GM0fk011qbQeayCXILczaZaZoSzdEKWSP20w=;
        b=KXP9DNGKEjHVvZLJ5rIwZMPGFAnltlbmFPUAFbH7UMXwf44WaT0DV5hu2MweMeJ54c
         hsaWHGTFtSaGwhrS6fTcQgHmBkXXoWk0BiUrPVrdsDEyU29cxViPaVYlG04V73rmP6bX
         S34U9xPiPoguE5uqAOKFCn5F7csp8QJ83khHAKsMNod37F5WwN7kyxMHRrLnrpnVHQcx
         Pt6k8p4QfCGqXBy7NOpraSi7ztJK9HomnLkOv6oAwKX2W/5AjKEDSTvyAZkNDweBeueR
         Yvq8oDr0PLnrH2HWlspqHGBQzUnbGrjZ4/dqRohl77NEvEP22vwLR7NRIjARdos9c9tK
         jhzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783357657; x=1783962457;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=bTKln45GM0fk011qbQeayCXILczaZaZoSzdEKWSP20w=;
        b=i0aGJ97Cvun1MfPl0PVDF9Nyrg+GbTlwl0zsZPj6YghbsJxexpthEIUaNSDrIA/OdM
         TpDc4UnDszZXin7pVHMPn9A2S6QooHjosiHkrGRUm/iG+Hnsqq7ZhWrfAaQJ37XNUSBs
         r9heCQHMO9M1mj3QN66eI2+/5L9mtTxfNkv5ntvGJUD0ksJ6zC+5xqwMz3bBgxBCNEwQ
         MGsCudo69mBkibgrNb2cYXwULRgBKXT3NhOujsh/ksmgfbqvHEE/C+xGGfbuYwV9c1XE
         EF1/WF/eNu8O4L69jnXNOUDJPNMCaQBwjx7RzoR1d5MfQ7JGvgO9pd3MkXrBpaaNqpVj
         UekQ==
X-Forwarded-Encrypted: i=1; AHgh+Ro49kQVhVse2Fp7279uK7yhh5w4h4QHvAVjORb91qwIem+MDUkehYNONEiqzWI1JUz3OWGhIJgWG5bt1QQf@vger.kernel.org
X-Gm-Message-State: AOJu0YylrYKmO13RGXuAhMlx9aEnKa0rUhrNz93SSLRsrvE0QQVYcbHT
	GfE3byxzp42E6maTa5z2fEfFz9WBtdWKslbWp+f/8RIOmi25M5Fll4vs
X-Gm-Gg: AfdE7cmtj0/SOUS7LM4jEZH0cvlMpWMRvbcdTA//sito5gSqU59guZEfaxN8fvhHqoW
	xF2bPFYkm+lZXlVtRFloxS9dMJ4rfUQkeZnhxY5P5LJadz5PLkbD7YH09YyKBCdSSK5OiUk4rfE
	Q5U7AS0T8uAKTxxbj/M/DVLQCSWpJ2FdMovdQ602O/me/nLMLErTq/QyhkuBkUGT2x9+bV4xzXO
	u+FhT4aBe6Z6EA0LhBkhH7kGNlR2h5OHtI0q8SFZe1ocKIpLeo/2jtxVms1P9VCyuRvdLLLm8B7
	+Ojp20N0qFAIelKBvpiWUD2rKROBp+jQ9scnxOf1mwhL41HuVE2DIs5qEXZ/YxEAB6j7d6gcwuN
	lSLBhjqpaaItOawIK6wYwgKNVajPPQkGqXhrTv/+2cIhCyxYqvVgryUo8TdN2TeeDjrLRC3U7tG
	NiT+er9VhpSurEqR79Z33uqOystkGoI19DBTKXJeRJ4ZXZjHYEPhMFFo0qbz61H8TfyiuJJ761n
	/WYNfA2R6InNuGjvT7fgUqHvkc=
X-Received: by 2002:a05:6512:48cb:b0:5ae:ba8f:f9fa with SMTP id 2adb3069b0e04-5b007c0b9d4mr246661e87.18.1783357657394;
        Mon, 06 Jul 2026 10:07:37 -0700 (PDT)
Received: from buildhost.darklands.se (h-158-174-102-211.A469.priv.bahnhof.se. [158.174.102.211])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5aed13bb774sm3031918e87.48.2026.07.06.10.07.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jul 2026 10:07:36 -0700 (PDT)
From: Magnus Lindholm <linmag7@gmail.com>
To: jannh@google.com
Cc: arjan@linux.intel.com,
	brauner@kernel.org,
	ebiederm@xmission.com,
	jack@suse.cz,
	jake@lwn.net,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	regressions@lists.linux.dev,
	stable@vger.kernel.org,
	viro@zeniv.linux.org.uk
Subject: Re: [PATCH] proc: protect ptrace_may_access() with exec_update_lock (part 1)
Date: Mon,  6 Jul 2026 19:07:35 +0200
Message-ID: <20260706170735.2941493-1-linmag7@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260518-procfs-lockfix-part1-v1-1-5c3d20e0ac33@google.com>
References: <20260518-procfs-lockfix-part1-v1-1-5c3d20e0ac33@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

while testing my Alpha generic-entry series on top of v7.2-rc1, I noticed
that several strace --pidns-translation tests started failing. The same
generic-entry series on top of v7.1-rc1 passes these tests.

I bisected the regression between v7.1-rc1 and v7.2-rc1, always applying
the same generic-entry series before testing, and the first bad commit is:

  6650527444dadc63d84aa939d14ecba4fadb2f69
  proc: protect ptrace_may_access() with exec_update_lock (part 1)

Examples of failing strace tests include:

  signal_receive--pidns-translation.gen.test
  so_peercred--pidns-translation.gen.test
  tgkill--pidns-translation.gen.test
  tkill--pidns-translation.gen.test
  fcntl--pidns-translation.gen.test
  xet_robust_list--pidns-translation.gen.test
  xetpgid--pidns-translation.gen.test
  xetpriority--pidns-translation.gen.test

One simple reproducer is:

  cd strace/tests
  ./xetpgid--pidns-translation.gen.test

The failure looks like this:

  ../../src/strace: NS_* ioctl commands are not supported by the kernel

and the decoded output lacks the expected pidns translation comments, e.g.:

  - getpgid(2 /* 6 in strace's PID NS */) = 0
  + getpgid(2) = 0

Looking at the patch, the relevant part seems to be the change in
fs/proc/namespaces.c: proc_ns_get_link() and proc_ns_readlink() now take
task->signal->exec_update_lock around the ptrace_may_access() check and
namespace link/readlink handling. strace's --decode-pids=pidns code appears
to rely on accessing /proc/<pid>/ns/pid for short-lived tracees in a nested
PID namespace, so this looks like a plausible connection to the failure.

The kernel has the relevant namespace options enabled:

  CONFIG_NAMESPACES=y
  CONFIG_USER_NS=y
  CONFIG_PID_NS=y
  CONFIG_CHECKPOINT_RESTORE=y
  CONFIG_PROC_FS=y

I also tested the basic nsfs ioctls with a small standalone program, both
outside and inside "unshare -Urpf", and NS_GET_NSTYPE,
NS_GET_PID_IN_PIDNS and NS_GET_PID_FROM_PIDNS all work there. So the failure
does not look like missing namespace support or a simple ioctl-number issue;
it seems specific to the proc/ns access pattern used by strace's pidns
translation code.

#regzbot introduced: 6650527444dadc63d84aa939d14ecba4fadb2f69

Thanks,
Magnus
