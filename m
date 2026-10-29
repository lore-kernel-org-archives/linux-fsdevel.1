Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793297399;
	b=gy2tLASd96SyKUjFofQmSzJiEnItRBEuyd28CVlrL5hJh/iRA3NEnoeYZU1QNqLfo+iU
	 DaLEJJjEh1mvdK8kaFey6NFJll2VTowQ8rEmL6626N9dB+k5dY5kb4+8WUY9fK/mVvdew
	 XJ7G6cqEkDoGiHeJ6TxjhLm1UCLkXkQX+cJyGDT7bg52rZCm73T2PJcBvuPEUBBoKLzap
	 epscM2LEEXVUC4ekVz7D9W+oOmFb3YLyAQl0MP0/XrJYd7lZ+yJ7nTDc+1kt+3TTuxsRk
	 dSa5CkVipH2StGGCf2a/5yOCvzyd6/2nicdS1tCB4Die6nAwlOPqhZQsR6urDogbpjQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793297399;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=s15KPFvSCwNiVaqBAYJFg7BNb25ktBO5/NM/9ViUK+E=;
	b=wobXLCAYMlO7nZmC6O/hlvlZNQdwEW0YVzKBASJm2xePOaol64GiwlKTNWCExEYZBG4V
	 uRlvP/Epa6cffTwC2b99ogJcZ7P2B2lFv+ntcp7mbExQc5qvBEdBefpIaRQmg5t4zf8Wf
	 XStd4DakNX+hBSBSpNgveoQFFeC3nsJTdUjqPXPd25ompylXnI3Dg3AKfRereHr1WaooI
	 uslB683Qrz/vd/KRRkxfqsAM4LzXicBlKEpcKGZRszd4MewmpHzR8LgLzWeTfnqqcl1dQ
	 7aqG8WpT8kxP5noNqn43Jo26/Ryj3+VAKyjeqK4ps9lzLaflbjJoRu7VvEEjuwvg6tQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=hammerspace.com;
	spf=pass smtp.mailfrom=hammerspace.com;
	dkim=pass header.d=hammerspace.com header.i=@hammerspace.com header.a=rsa-sha256 header.s=google header.b=VHAaoFOq;
	arc=none smtp.remote-ip=209.85.210.52
Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com [209.85.210.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B3EF60A262A
	for <linux-fsdevel@vger.kernel.org>; Thu, 29 Oct 2026 18:09:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7B3EF60A262A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hammerspace.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hammerspace.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=hammerspace.com header.i=@hammerspace.com header.a=rsa-sha256 header.s=google header.b=VHAaoFOq
Received: by mail-ot1-f52.google.com with SMTP id 46e09a7af769-8256106635eso1247534a34.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 29 Oct 2026 11:09:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=hammerspace.com; s=google; t=1793297398; x=1793902198; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=s15KPFvSCwNiVaqBAYJFg7BNb25ktBO5/NM/9ViUK+E=;
        b=VHAaoFOqccV0hFbc/ilFGOCwBwlm7TlXY62UVXoSJHQ6ULl7rIxY59eOHwq0CF9/io
         uHUH5dNGfW/I6lhPVAh1H4wl2sE+JeC5MUR7zR8iFZcLo83oTar/Ry3m6+IHkan6JPXp
         m8yPcXCpfLKjhJ1tr27UMZxgXiTjjZ1jB5zwZj8j/4LeMnwZbNb0IYPUMYVNbhsCkAjS
         7FJCNZnQJpgwLJo7Sfn8xu+cf7XjBdAcnz1xKs+65uWE3QDT5DOvkhQY1QJpC2Ll+8uF
         9ack3+/n9ZsYHkPe91Zh4sm35qFh/wyOPftUXrqDqZNtR3wbp+nTsCMweOAnQu+vjU/U
         9NyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793297398; x=1793902198;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=s15KPFvSCwNiVaqBAYJFg7BNb25ktBO5/NM/9ViUK+E=;
        b=UHVX+hwjKo8eVq+IHWNuYXQjCEVaRpjj/3z2wB0scOya3H8proe374zSabhY1zWDN8
         DvFipPX4Qt2tYWLsIVSBEwgzAsmL/drdPrkAFktbmU2gy9iebhzhnVGQlTJ0oCUUHSTL
         Tzsy3C9Y4b1n2cRambCOO2hES/uIugOiCSBlrmkb+LlZ1pcyAPL4x8XndJRIfMJFjFGV
         69S7lCu6UsS24TTYU8bNxIAF0NQVOU2NNV60czA1gaFaV5eQ8sAxMGACpSON2WEyxsWC
         fQyXWRnqsMb3FiUPDfMjlVwu1uxTa3Hiu61Psrm3ovYcRuSh1vnUxuKgd1zYC77Jg3KN
         X+Gg==
X-Forwarded-Encrypted: i=1; AKwUvByGCpQ0OsgEgNUdeVtLZdb5ILd85zH0AO4vOkUL5IeblZ7LfU+mrR2wMyGUGtQ1X3vdp3ub0ARTVGqAme9Q@vger.kernel.org
X-Gm-Message-State: AFq9FYKA/c0LsNK95h0SoMZS2SGjZ/5zDP9BeuhokP0P5QzZ85Qc9tAt
	Y9mfXaYE5R3XD2neVe7eDBmX60/k13pbGFuHxsctg0MIg60JtX8x/YktgPO2i3AZkDY=
X-Gm-Gg: AYBFou3rIyyy+lMZwKtKCJhvhgjW1wv5VBXZ8R+8v28o+vWlqjgOZNEFkE+8Jg6O3i9
	lF5NS9YiS78emDljQc3MgjeR9ahWIf7k25ru1DdXLK1KSNjBXvrgwlR2n3YS3nRCED4KOKKrXEm
	ozlcCh03aSetFGKWkmz/xaYB0kbpiMPO0e6va+XTDsDAqTjDmfYwpWe7Pk2vOJ+X7YMmH/jpXct
	PWCOu/d+mSmGoIBWcEvSoP96jElbaMpX5ddkSN/GHBG9niuYLSHgkxFRahEwFt9Z62oIY4bSLPe
	+V9VqiSGr35XFardEDYTCqn0W6HmBfRR0WJc8I6duhTvAWCAi41S2MEFlPfB3enZkLuI9dZquhT
	u7OXtD58Rcw4ZY1ysxIsX/fxEF91pI/3LVs4vSk7MONXrrGz3kQ1MTHBWgFyVEj7VoYHzZutHtr
	eduZkHn/J6WHmQJLt7d/rc/FM6etB5kFC2+ITHVkZx3LZz/+WjReZjbboGXdsUx4G34LgE+oRAT
	sV/dq/wWu2+DI01g4dUuCBTnNriqKtIW5cQ8yH/ILG4HiDfcO9wSb50KLh/GUF7SFnIbzwIxJQe
	1EKWWuikISzVaRDU7EpGmxSfSERRjPKUv6xOrMUO/MRxDRWPKuSx9apMbXmbFshTOj4+wPYC
X-Received: by 2002:a05:6830:4120:b0:81c:dbd7:65dc with SMTP id 46e09a7af769-85abf770d16mr4912244a34.7.1793297398266;
        Thu, 29 Oct 2026 11:09:58 -0700 (PDT)
Received: from localhost (75-163-200-235.clsp.qwest.net. [75.163.200.235])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-85d3545b847sm156364a34.7.2026.10.29.11.09.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2026 11:09:57 -0700 (PDT)
From: Jonathan Flynn <jonathan.flynn@hammerspace.com>
To: NeilBrown <neil@brown.name>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Trond Myklebust <trondmy@kernel.org>,
	Anna Schumaker <anna@kernel.org>
Cc: Jeff Layton <jlayton@kernel.org>,
	Chuck Lever <cel@kernel.org>,
	Jan Kara <jack@suse.cz>,
	Jonathan Corbet <corbet@lwn.net>,
	linux-doc@vger.kernel.org,
	linux-nfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH RFC 00/12] vfs, nfs: concurrent create and unlink in one directory
Date: Thu, 29 Oct 2026 12:09:45 -0600
Message-ID: <20261029180957.387138-1-jonathan.flynn@hammerspace.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261028041023.3738553-1-neilb@ownmail.net>
References: <20261028041023.3738553-1-neilb@ownmail.net>
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Neil,

Thank you for this series; it is what makes these patches possible.  I
had them on your v3 and have rebased them onto v4.  They extend it so
that processes on one NFSv4 client can create and remove files in one
directory concurrently.

  operations per second   parent exclusive   parent shared   ratio
  creates                            2,616          29,939   11.4x
  removals                           2,157          32,360   15.0x

One client, 96 processes in one directory, each creating files (open
O_CREAT, a small write, close) for a set time, then removing them all;
NFSv4.2 to a pNFS metadata server that is not knfsd; your v4, the 7.4
VFS changes it builds on, the three silly-delete fixes and this series
on a 7.3-based kernel, among other patches.  Each row switched only its
own path, by a test-only module parameter not in this series, with the
other path on; one run each.  The creates row comes from 300 s of
creates.  The removals row comes from 120 s of creates, and each of its
runs removed about 3.7 million files; the removal rates vary with that
number, so it is given.  With the parent held exclusive, operations go
one server round trip at a time.  2/12 quotes an earlier measurement,
on a 7.1.13-based kernel.

How it works.  2/12 lets a filesystem have the parent locked shared for
O_CREAT (a flag in a new ->iop_flags field), and 6/12 for unlink(2)
(->unlink_shared() and ->unlink_shared_done()).  The dentry then
excludes the name: for a create, its in-lookup state, all
nfs_atomic_open() needs since your 3/9; for a removal, an NFS mark that
lookups, opens and creates of the name wait on until
->unlink_shared_done(), which the VFS calls after the fsnotify delete
event, if any.  What NFS cannot order that way, such as an open file,
it hands back to ->unlink() under the exclusive lock; where the server
reports itself case-insensitive or not case-preserving, NFS sets
SB_I_NAMES_COLLIDE (3/12) and both keep the exclusive lock.  Both paths
call d_alloc_parallel() under the shared lock, as lookup does.  When
your directory-locking changes lift d_alloc_parallel() above i_rwsem,
these calls have to move with lookup's; the exclusion does not change,
and the opt-ins go once the VFS stops taking the parent lock (2/12,
6/12).

Patch flow:
  prereq   1  store re-read server capabilities in one step, for 3
  create   2  VFS opt-in to take the parent lock shared for O_CREAT
           3  NFS sets SB_I_NAMES_COLLIDE where names can collide
           4  NFSv4 directories opt in for O_CREAT
  remove   5  factor vfs_unlink() into a helper, no functional change
           6  VFS opt-in: ->unlink_shared(), ->unlink_shared_done()
           7  a second ->d_fsdata mark, for removals under a shared lock
           8  keep a dentry carrying that mark hashed
           9  no new dentries from a listing that a removal overlapped
          10  the removal method, handing back what it cannot order
          11  look a name up again once its removal has unhashed it
          12  NFSv4 directories opt in for unlink

Three fixes for the silly-delete hand-off, which your 2/9 makes
reachable, are posted separately, in reply to 2/9.

Tested on the same kernel over NFSv4.2, with the new paths on and off:
removal races (with listings, and with tasks killed); O_EXCL creates
racing unlink, with a kernel-side check that no revalidation trusted a
removed entry; inotify event order; two clients; and an overlayfs mount
whose lower file another client renamed away and back.  All passed,
with no kernel warning or hung task, except the two-client test's check
that nothing was left behind: on this kernel and on one with an earlier
revision of this series, it found one silly-renamed file in three of
four runs, with the new paths off as well as on, so they are not the
cause.  Each time, the file left behind was not the one that had been
silly-renamed: the silly-rename's RENAME, which goes by name, had moved
another file of that name onto the hidden name.  A PROVE_LOCKING and
KASAN build ran the removal, killed-task and O_EXCL tests with no
report.  A case-insensitive server, where two spellings of a name never
made two files, was tested on that earlier revision only; that code has
not changed since.  Not run: fstests, knfsd as the server, NFSv4.0 or
4.1, directory delegations (the server grants none), CONFIG_DEBUG_VFS, a
weakly ordered CPU.

One question: are the opt-ins in 2/12 and 6/12 acceptable as interim
interfaces until the directory-locking changes land?

The series applies to 83f32c773255 in Linus's tree on top of your v4
and the three silly-delete fixes.  fs/ compiles there without warnings
at every commit, with and without CONFIG_DEBUG_VFS and lockdep; I have
run it only on the 7.3-based kernel above.

Tools: these patches, their changelogs, the race tests and this letter
were written with Claude Code, using Anthropic's Claude Opus 5 and
Claude Opus 5.5 models, at my direction over many sessions: I chose
among the designs it proposed and directed each revision.  It found, by
reading the code, the bug that 1/12 fixes: while the client reads a
server's capabilities again, a capability the server still offers can
look missing.  The three silly-delete fixes, posted separately, say
which of their problems it found and how they were tested.

Thanks,
Jonathan

Jonathan Flynn (12):
  nfs: update a server's capabilities in one step
  vfs: allow the parent lock to be shared for O_CREAT
  nfs: tell the VFS when two names can be one entry on the server
  nfs: concurrent O_CREAT in one NFSv4 directory
  vfs: factor file removal into a helper, no functional change
  vfs: let a filesystem remove files with the parent directory locked
    shared
  nfs: add a second mark for a removal made with the parent locked
    shared
  nfs: keep the dentry of a shared-parent removal hashed
  nfs: do not cache a name from a listing that a removal overlapped
  nfs: add the removal method for a parent directory locked shared
  nfs: look a name up again once its removal has unhashed it
  nfs: remove files with the parent directory locked shared on NFSv4

 .../filesystems/directory-locking.rst         |  60 +++
 Documentation/filesystems/locking.rst         | 259 ++++++++++++-
 Documentation/filesystems/porting.rst         |  35 ++
 Documentation/filesystems/vfs.rst             |  25 ++
 fs/namei.c                                    | 360 +++++++++++++++++-
 fs/nfs/client.c                               |   1 +
 fs/nfs/dir.c                                  | 300 ++++++++++++++-
 fs/nfs/inode.c                                |   2 +
 fs/nfs/internal.h                             | 211 ++++++++++
 fs/nfs/nfs4file.c                             |   9 +-
 fs/nfs/nfs4proc.c                             |  35 +-
 fs/nfs/nfstrace.h                             |   2 +
 fs/nfs/super.c                                |   2 +
 fs/nfs/unlink.c                               |  16 +-
 include/linux/fs.h                            |  72 ++++
 include/linux/fs/super_types.h                |   1 +
 include/linux/nfs_fs.h                        |  28 ++
 17 files changed, 1361 insertions(+), 57 deletions(-)


base-commit: 83f32c773255720a661aa45d83e36278135f23f5
prerequisite-patch-id: 3405b4d6ab8b0bf24ba63a898083d617deec4f24
prerequisite-patch-id: 096657d6d80d7ca533ccb574d2af65611ede4af2
prerequisite-patch-id: 1a2319c14739918aef86116647fea28ae85ad4df
prerequisite-patch-id: 725cb18c3936d50141ef27dafc159bf50b64a5bd
prerequisite-patch-id: b39cdd352b97e2cd247311fd5db620dbff227bd7
prerequisite-patch-id: f9f3f0e945cadf96113d4ac9ab8f7b0c207af4e5
prerequisite-patch-id: 4c09a15390bb556d79bea1ee733f52a58bec80ef
prerequisite-patch-id: 7c026717a97b2c86a169539822f5d14650f68f8a
prerequisite-patch-id: a702d54495d0f3d7f88b82411d884dcf5aacf9a0
prerequisite-patch-id: a7e7263e8916612f3e4b767946b5d9259029f50e
prerequisite-patch-id: a8e5414df9d9912dcdf9bb1dbb2811ce326a1e1f
prerequisite-patch-id: e8050b998d5790f3bb4311bc65011735ed7d8b2f
-- 
2.43.0

