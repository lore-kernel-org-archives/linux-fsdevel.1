Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 000C5379980
	for <linux-fsdevel@vger.kernel.org>; Tue, 18 Aug 2026 19:51:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787082702; cv=none; b=cx3TLrC/DsCn5x68+CdLCjB+793j8N68aLu6BFXZSQhPoakxVCrcptOg90p6wcazFJRLwNDv6Ld2kwzI+aii3zp6OrxZ9hYkchl6iiR/4jK0nUg8It3hJtpmDeldxnyZA569wkYjRlAD6HxU1lvoDoWTguZ/DAs9g/b1sigD+/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787082702; c=relaxed/simple;
	bh=tzzbnGcfHutO0vdB1fh0UMZvNK7uVy3ulgec3GLoLDg=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=OgaOpKHe7xZpVfmFkNTEBWBeGYlM6+tQlUsAhheRlUxsJtlDy4de2C8zlIlLmXIaqlqcLfH25dbImbVhMWyhWaOeeUdg5UdtvHQG3KJzgqPvCzbjXve3iGhUvihDnL2l3n9rVUuayW6t2ep2IypuBE+uJxwo+5nux+qfPFg7qEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=k7buk6ZH; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="k7buk6ZH"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4996e2575dbso2825e9.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 18 Aug 2026 12:51:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787082699; x=1787687499; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=drSOm1ixDHQGlI3smzn5LxemApeC9uWCJGzFJcvqnEk=;
        b=k7buk6ZHMiUo0C4sH80VKl4ZnXa/OuRc+LCuAINTApGJJTxcB4gyhWoZM6vmCF1TkP
         DlfIBoNPE63jv5nAi0579D1HNKVVdiuKrHXASR9F97Q1NW7GQMJKn2G9TEn21I/qIxyL
         x4yDcSozUEfBUrWq/zmNiEDpXLAJ0a5tCHAAzHcry4z3JE2F4EFhzLOrns41uHqJFX4V
         veDm/g36hkRPKbQlpRTKUPXPpObtvrmXpvqG5ugmUk4oIBucKo8pVkkWiokjmmqg4qNK
         b0dogfozf1I96qd4h6fpgT072Le3y3ndcBY/OdTvrorH5TYXi3SQj/umAAJtMbNRqJm1
         uQzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787082699; x=1787687499;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=drSOm1ixDHQGlI3smzn5LxemApeC9uWCJGzFJcvqnEk=;
        b=X6ttFlYcKZ25P6HusY6ndgl+fLRjp7WrvHRya408Cwu6uTGexQg5XbPGlbeSDe3uQG
         y956xUPof5qA1Fl2vbR+4Uvntnq9UFvUiHWgghfLY9MYS8vYwGLPBviLwQZtsTGbzp8C
         KFHt45NKduJshWg/otvVah94XMqTLaGOng/8zUeqaFVVzVMSr9bkSMDD8yugYhPtHoSc
         6jlI+bSOoyMkiHOx+aK224yxFBgqEO+l5T5XfFNrglIntnRSStyrO/K4iHnOw+sYrZ7B
         cEYqaPRhY+oaNNePH5mxg2WRpbwR6QKa6AKR1mIcMu+fvMjxVrWM3aTlNrpJBXHyXYjY
         TpYg==
X-Forwarded-Encrypted: i=1; AHgh+Rqqu9WkO/tuWPT28Nby+UbIUuQ3+JziLAm71pb9csSAJKMZ/Vsgo4PcuUeEKvtOxIvowZhZBfoBd0XbxsVz@vger.kernel.org
X-Gm-Message-State: AOJu0YwTc+fURbxpiYOvlaOMg+3YRFs1HTqQ9aoLpbWw40tsbEBKtDaF
	++XN910UDGKBemA5uhRCwTXYdBMlv5D+capT7tYrskqIm1TM55XaoMseRBsBWj+JEA==
X-Gm-Gg: AR+sD10kyCxHv1q02uT7vg8Kyl+D842wYP9ZBwX5tkN+IxMvawlRF2ymGwkJ/f1OaTR
	Bc7VMgBMps6Xpd615JNXCjOmkKKoVuvnpQAALoiNjHm53sWmhvihEWiHi88nJSj/rvZHSsw7C31
	1u8lCLMKbq5RbQ4qDiviFuZO9ebvaD5hYKPuQyF8jK/L8j7d+Xlk5wsn4FtLl7eh5WIgadGWLpu
	h8P5DlGGKFONgfV56HXA/hIRPxE4sOHb/rvoVB2GNo8Z9eqiWoWvkjUwV8onj/iIkGGwpbCUX1A
	w3zZ2SkNVVuaF6j6C7Bo+YtPPIDOasoMoHCnYHqXZ2qeGxAXNsI9BZgurz41gvirHyy4jByDycm
	2xiwCeb8WxbkKlaqcPdoWsMEhXD8Bg/gCn6Tv9iX75TMQutWb45p4Uhqmpjn+mFQxRMXbFP/XWA
	wAeP5oEU959FXMNKcwljb4W8LVslheCveGZOAcR4lOB4Q7lEnW6klXIvZNoL5HmHCI+LG+xhcx4
	gTEZO1R0j1FRrlvnV3okPSM6i2X6PQgmQ21hYeMCv4nAqZcMYiN9Q==
X-Received: by 2002:a05:600c:254:b0:499:7da3:dd0c with SMTP id 5b1f17b1804b1-499a94ed422mr57545e9.0.1787082698942;
        Tue, 18 Aug 2026 12:51:38 -0700 (PDT)
Received: from localhost ([2a00:79e0:288a:8:f466:5a15:1301:318d])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4999d0fb85csm210096385e9.11.2026.08.18.12.51.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Aug 2026 12:51:37 -0700 (PDT)
From: Jann Horn <jannh@google.com>
Subject: [PATCH 0/3] proc,security,selinux: let SELinux block FOLL_FORCE
 for /proc/self/mem
Date: Tue, 18 Aug 2026 21:51:04 +0200
Message-Id: <20260818-selinux-pokemem-v1-0-90cd2357ee05@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAKi3hGoC/yXMQQ6CMBBG4auQWdsEmikQr2JcYPmFASmkA4aEc
 HerLr/FewcpokDpmh0U8RaVOSQUl4x834QORtpksrkt87pgo3hJ2HazzCMmTIa5tM65ynPLlKo
 l4in773i7/63bY4Bfvxs6zw9radgVcwAAAA==
X-Change-ID: 20260814-selinux-pokemem-44625557c4d4
To: Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>, 
 "Serge E. Hallyn" <serge@hallyn.com>, 
 Stephen Smalley <stephen.smalley.work@gmail.com>, 
 Jeff Xu <jeffxu@google.com>, 
 =?utf-8?q?Thi=C3=A9baud_Weksteen?= <tweek@google.com>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
 linux-fsdevel@vger.kernel.org, linux-security-module@vger.kernel.org, 
 Ondrej Mosnacek <omosnace@redhat.com>, selinux@vger.kernel.org, 
 Andrew Morton <akpm@linux-foundation.org>, 
 "Liam R. Howlett" <liam@infradead.org>, Lorenzo Stoakes <ljs@kernel.org>, 
 Vlastimil Babka <vbabka@kernel.org>, Pedro Falcato <pfalcato@suse.de>, 
 David Hildenbrand <david@kernel.org>, linux-mm@kvack.org, 
 Jann Horn <jannh@google.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1787082693; l=1964;
 i=jannh@google.com; s=20240730; h=from:subject:message-id;
 bh=tzzbnGcfHutO0vdB1fh0UMZvNK7uVy3ulgec3GLoLDg=;
 b=HhNdXV2fub0RF+OgbExoBb2DXb+eAiN7VBv2jprX6UnhpvnrUS2oTrBxlzDBG1Smiw3tvds7u
 /RA3CIJ29a5DZBSqk1r0aeUsB+aTrR6g2NeP2huXaOBXrPr7EzT7TP2
X-Developer-Key: i=jannh@google.com; a=ed25519;
 pk=AljNtGOzXeF6khBXDJVVvwSEkVDGnnZZYqfWhP1V+C8=

The goal of this series is to let SELinux prevent the use of FOLL_FORCE
when a process writes into /proc/self/mem and the system is configured
with PROC_MEM_FORCE_ALWAYS (which used to be the default behavior, and
is still used by current Android devices).

Android has SELinux policy that attempts to ensure that only trusted
code can be mapped as executable in several system processes, but this
protection can currently be bypassed by writing into /proc/self/mem.

I wrote this series after discussion with Android security folks about
the state of proc_mem_foll_force() restrictions on Android.

I'm sending this to:

 - maintainers for LSM hooks
 - maintainers for SELinux
 - maintainers for VFS (because I think they generally own procfs?)
 - some MM folks just as FYI since this touches GUP usage
 - the Android folks I talked to about this

I think this should probably go through either the VFS tree or the
LSM tree.

The motivation for this series is that Project Zero managed to write a
remote exploit for Google Pixel partly because of /proc/self/mem, see
<https://projectzero.google/2026/01/pixel-0-click-part-1.html#whats-the-plan-seth-and-jann>.

Signed-off-by: Jann Horn <jannh@google.com>
---
Jann Horn (3):
      proc: refactor /proc/$pid/mem to use struct as private_data
      proc: query LSMs for introspective mem access (if PROC_MEM_FORCE_ALWAYS)
      selinux: require EXECMEM or PTRACE for FOLL_FORCE introspection

 fs/proc/base.c                | 35 ++++++++++++++++++++++++++++++++---
 include/linux/lsm_hook_defs.h |  1 +
 include/linux/security.h      |  6 ++++++
 security/security.c           | 15 +++++++++++++++
 security/selinux/hooks.c      | 27 +++++++++++++++++++++++++++
 5 files changed, 81 insertions(+), 3 deletions(-)
---
base-commit: 2f1baf1fc8929e6c48370be543ad028ac7ad4131
change-id: 20260814-selinux-pokemem-44625557c4d4

Best regards,
--  
Jann Horn <jannh@google.com>

