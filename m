Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793138771;
	b=cRNLAFwSTpQX4PP+F/pDLiApdViPB9yeg/tn9FFNKYs5F/8IY7iVM0S4RDiULbu1K7ox
	 LR+Kl8qNpdEYOROFiejMHhVpfnwnrNHPTPKykAxLkAixmhDZq4ZZSvVVh8iDDiXIL9vGs
	 hPGzPoMY8qFS9ZC6UUIuPkXMKj4jRa9uKLGKzfzpYyHfNKT4Bxk++XT4YqYMdrWioDv6b
	 nih/3LQy2wyo2qhZclyxwvKm5g32yz+p3rYeYIJ5KvmZ09tB35JpJpXLlb2e5Jm7GSMv5
	 pg0KXF/6VjuAFazRSUkoEdHyfB2rUSosO7g5dW1Xs1SBYLYOSR/on9n+nltapdyLwUw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793138771;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=rIISIsaD3SsV5IRNYcwW+Z8xLRmEV4veNrpT9AIVtfs=;
	b=ZBmETXcbhSq6Dsfe43z4fxVsfPJ1H/3I/uSdV2JItw9GM/R+5zUJsMEswXa96mwTYPQC
	 uv3ZZzYJ1XNDZTEk23IgDaTOG9WlRkv+AlwcwtqUk944Oq3w2lKN+12w7LGQgPVRBFsjW
	 IJ/wkpALEEeDhi67rMHZe6Kkps31esR++kUMed0N24peuZvbNbRyWSKH6Pff5WoYFUK01
	 vs23G3SjRr2EAg4uSmZYUPVC5eLTDbQ+5pLNSZ1QihoiDggCRKBQHBfihpgIE20AkLgDk
	 5vdErRPwoIegkMMEFQ0WhxMaDn45gA71po0uTDGEYXTJgnuq8Qv41mpSPatenx+dWvg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="wlWwIEp/";
	arc=none smtp.remote-ip=209.85.128.54
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27049606A31F
	for <linux-fsdevel@vger.kernel.org>; Tue, 27 Oct 2026 22:06:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 27049606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=wlWwIEp/
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4a4d7ae1ae9so2793325e9.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 27 Oct 2026 15:06:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793138768; x=1793743568; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=rIISIsaD3SsV5IRNYcwW+Z8xLRmEV4veNrpT9AIVtfs=;
        b=wlWwIEp/o9vbgARKb2Ee8BFghO0vL9bW7IR/oRtT1+OfuhvyL1ErNsFRXsAjBBB3+j
         tEd+b7yXQALJLRSOggnY6nL56XOpZa50Z52FC6CA74yiJnTiHxZ8tLN4LsYNg2JBo17z
         6HL24Zx9Yrc/+CXxetlmQRAkf3vHKTCdDCkcRzSzKdTgeSptK68dY8hLalLkoGzAMjc8
         qsApUrgkUjcRxiCp9eHxvpByWAF/BILDGcM/B+Hu+v0Jv/YZNNzgkvJOGORfNzHukmKl
         Pw2fRNx391Ml+kw3XYWZa2y/F4P+tnvbJ1OWkGVunc+x9SamgxEbeZ2pnNFEULXzCYJ/
         TcJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793138768; x=1793743568;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=rIISIsaD3SsV5IRNYcwW+Z8xLRmEV4veNrpT9AIVtfs=;
        b=K9IKeijr1tuDjawpURZa04bXC440MV7qFLteJ4yKfsSaLib3VU03snpKlA4xw6Iic/
         DzhreSzgVDp16SEjNcz9cC0zhBT6AJZ+IbXThtwTqJ0/K6yH6zB8xFLdSkxh0Om/3W+6
         egavrdAYNELtbJLnhUhorCsF4qdX919ujN5JX9A95ps9RklR3DvSDB4FLwKhg4ceje5t
         2OIc1Vr/TYSFkQGhwuQX2qSCMmjEj/2eHBbFbPZe02YDRllRH9ck03xRUZ+9hQxuC7sf
         kL/EAM4NX/ZIrofxM6xY3yD5ZQRWp74OwpmtH8Rnx7Z0L0pk+RFRerS/FVVDtZR1U3iT
         q5EQ==
X-Forwarded-Encrypted: i=1; AKwUvBw/b9j66yAp8NIyXqFcctSxd39V+50O9KclO1l/qPBh18voH2Xa9Nh9icDO3BPuZyquTTYxVNvRtDtu/R+N@vger.kernel.org
X-Gm-Message-State: AFq9FYLhpx8ANkkm3t0VXZkEJOjdWaZ4cxS4seRCwE1hZW9nfZ8xJ0Hf
	Ff7mcdXe23L94snxUy+ZUEJ8uHrYcSPE1XGZbW+JBNeeLNvdki2HG1JX
X-Gm-Gg: AYBFou0pBY0TI5fAUA6oFQrpRlvVoIWRR/MorS9YHl+L2hTX/KvXkU9YU2tJrQFEkFi
	aNtCs0REbVtqN1LFNfcwQJF5ku8gML8WiuXP7DJfABLGJVRAeOL63cgieA986jM1mwh3chIz9J1
	zMkPghgaZXkHfnrL5ib0QYnfxiZYxDR6X4n66iP8OyrVoO5IGK8lFZtsYjDXxpAH+gNy/ucjBUV
	K2rd8/gU8QKwrFU/Q6Yv+ylIiVcpTd+UGF6ISMfFTI7Rq3uDIAclifP/6U0l5EAjZ8Ulcj9tmRn
	G3wJZy/mcYkK3vHLORyTAmOaUKmNXd9wv211y2CABcyGIM1Zbu1jpuTWH/0FscjzOjP2OiaQToo
	g2eEDQP7nsrQ6ZE4JHxLmdHa9ywlMqdpj5wIHaINBqhcMRZ8hkS5mrUyc/SLBzlYZpDvWhf8930
	P2tDpI3JZyOvrCNLyP7SJtrN9BlUq2+9WdrYplGmDlQusr1e7s+KnJrKxE03Cw7fBlD8NO3Y23l
	uzMe3CB8m0XGgGHsjEVeFLRMwAeU2FB+D0x/rXhtbsumaa64yU=
X-Received: by 2002:a05:600c:4687:b0:4a7:c366:d791 with SMTP id 5b1f17b1804b1-4a974434179mr2801235e9.1.1793138768314;
        Tue, 27 Oct 2026 15:06:08 -0700 (PDT)
Received: from infinity ([2001:b07:5d26:7a6a:365a:60ff:fe0d:cfc6])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a977edc08fsm1752495e9.4.2026.10.27.15.06.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Oct 2026 15:06:07 -0700 (PDT)
From: koraynilay <koray.fra@gmail.com>
To: David Sterba <dsterba@suse.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>
Cc: Chris Mason <mason@kernel.org>,
	Jan Kara <jack@suse.cz>,
	"Darrick J . Wong" <djwong@kernel.org>,
	Sean Smith <defendthedisabled@gmail.com>,
	Andrey Albershteyn <aalbersh@kernel.org>,
	linux-btrfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	koraynilay <koray.fra@gmail.com>
Subject: [RFC PATCH 0/2] add provenance time (ptime)
Date: Tue, 27 Oct 2026 23:05:30 +0100
Message-ID: <20261027220532.736352-1-koray.fra@gmail.com>
X-Mailer: git-send-email 2.56.0
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

This is an initial implementation of a new timestamp to indicate the
time when a file/directory was initially created.

This patch series takes inspiration from the one by Sean Smith
<defendthedisabled@gmail.com> [1], but using
file_setattr()/file_getattr() as suggested by Darrick J. Wong
<djwong@kernel.org> in [2].

The semantics of this new timestamp should be at least these:
- it should be the same as btime on a newly created file
- it's user-settable, so it can be preserved for backups, filesystem
  conversions, archives and any similar operation
- it should be preserved every time mtime gets preserved

and the correspondence with the other timestamps is as follows:

ctime <-> btime
mtime <-> ptime

Examples:
1) a .zsh_history file created in 2019, then after a few years the user
   decides to switch to another filesystem, copying the .zsh_history to
   the new home, in that case btime would have the timestamp of the copy
   and ptime would have the 2019 timestamp (just like mtime would have
   been preserved)
2) a symlink created in 2020 from the home directory to a /path going
   through the same process as the .zsh_history, in this case it would
   also make sense to sync the ptime to the 2020 timestamp instead of
   keeping only the btime (so the inode creation time).

The proof-of-concept code (for testing) for stat(1) and cp(1) is
available at https://github.com/koraynilay/coreutils (master branch)
(Note: these coreutils code changes are a prototype and won't be
submitted upstream as-is, but they work as expected in simple stat and
cp -a/--preserve=ptime tests)

Lastly, the name "provenance" and "ptime" are not final, I personally
don't have a strong opinion on any name, but while testing with stat(1)
I noticed that "Provenance" is definitely too long for the normal
output, so another option which would fit well is "Origin time",
abbreviated as "ntime" (OrigiN time) and not as "otime", as that would
conflict with btrfs' internal naming and create confusion.

Thanks.

[1]: https://lore.kernel.org/20260405195007.1306-2-DefendTheDisabled@gmail.com
[2]: https://lore.kernel.org/20260407014129.GC6192@frogsfrogsfrogs

koraynilay (2):
  vfs: add provenance time (ptime)
  btrfs: add provenance time (ptime)

 fs/btrfs/btrfs_inode.h          |  4 ++++
 fs/btrfs/delayed-inode.c        |  6 ++++++
 fs/btrfs/inode.c                | 17 ++++++++++++++++-
 fs/btrfs/ioctl.c                | 12 +++++++++++-
 fs/btrfs/print-tree.c           |  1 +
 fs/btrfs/tree-log.c             |  3 +++
 fs/file_attr.c                  | 24 ++++++++++++++++++++++--
 fs/stat.c                       |  2 ++
 include/linux/fileattr.h        | 27 ++++++++++++++++++++++++---
 include/linux/stat.h            |  1 +
 include/uapi/linux/btrfs_tree.h |  3 ++-
 include/uapi/linux/fs.h         |  8 +++++++-
 include/uapi/linux/stat.h       |  7 ++++++-
 13 files changed, 105 insertions(+), 10 deletions(-)


base-commit: 21a7f44fd0765fcc5194130b28767786eba1d1e7
-- 
2.56.0

