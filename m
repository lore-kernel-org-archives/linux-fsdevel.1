Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.179
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792533830;
	b=UtNySqbnbtOpPtR7aC2/SRzC8KZ90BcJ8HsyR9K0pZ2XJvsLvpj5uipv5kMCkuRddysT
	 FJqn9FZsWhxAfJfTo2c1J6eipU7a5FmwokSuD0JFbQiCXX6CLmRjdPM1Ph1CWwTp6zSXb
	 6TB48LjAwJLnvwf0WW7I9oZjQCdQSbUC+bdU3DSBVrTFfu7w3aj7CFm6p7ejeqeGbLArm
	 El7FuyXYvxh3gglWkMjszaShCgmiWuI++qGgpQX9GqAM5bzisZQmrx+NZ/ruoMG1U2oFK
	 ADhXTaWfTBcrD5Cx/7sph7ufDObiRUJStQYWFgWSbHHWpPbwvSbxJy7/E6W1Hn0UBRQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792533830;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Sender:From:X-Google-Original-From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=oiJsb2ENhg2Lat5WWUqDnx4kJNVMy/Qtqe/7sshNmdw=;
	b=m10HDrEzBBtDx55mz+9Zadd/WKGCCBDy00ahw/A5MksqD2sSX/5MkwYh0J/jeXMO+DUW
	 J1YIn/+EeMGd00DQE+f8VW4m1Sv+mzUKQzCLbTxiaLT7TfxLftj2tQ54KGLC+tIAyWSTV
	 7cso2Ck5Xqv/L61oztEp0Nmrvl+TUSywOgD3gsf9b4lyuPZcBggsgrXpVHbPe7LyJ7XyA
	 UZaId1UNFBo6oKMlp/ue/eYPHLuN/b9Ao9z6dwGUBDjj74BtgLWyZPVaKo1dghh9b6l5b
	 hU44wxBZKWUnXnPFgRnDBEEdK1J8VHE2jwhk3/qf9BH44E8ZcZkGKuuzR91WVEAMcUg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=hammerspace.com;
	spf=pass smtp.mailfrom=hammerspace.com;
	dkim=pass header.d=hammerspace.com header.i=@hammerspace.com header.a=rsa-sha256 header.s=google header.b=ZFnNhEve;
	arc=none smtp.remote-ip=209.85.222.179
Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D19AE606A319
	for <linux-fsdevel@vger.kernel.org>; Tue, 20 Oct 2026 22:03:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D19AE606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hammerspace.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hammerspace.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=hammerspace.com header.i=@hammerspace.com header.a=rsa-sha256 header.s=google header.b=ZFnNhEve
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-930c0f9c1b1so10719985a.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 20 Oct 2026 15:03:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=hammerspace.com; s=google; t=1792533829; x=1793138629; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=oiJsb2ENhg2Lat5WWUqDnx4kJNVMy/Qtqe/7sshNmdw=;
        b=ZFnNhEve6ZaDIrkguLQFu3os/T1+WWLU+NkPNPa3zlr5VoP2WAmB5cP/ygoSWe18gi
         V2wCc1wPOdsQXV3LkCChpHcVzF/0IV8q26+djSJwnGBpKOlEL/FaOkf8Ex0jRPmTMOBf
         isH/oqd6+DmkuQtMkltxBXZ83AxLUyxe5hbcsIzumtmDMH1Q1hDYvXZgKOhfZ0n0oeP5
         TaoalkoFXzlmsyM7FNK5tUDSUssInWk2g6+tRhvtA9R/8jB5Hlswqa/K+KHQRbDTxB+r
         dyym+XJDe6qRcmXh6yRAydBXVvA9CLi8lAdrZqrCopTUCLgxM2Tf1RtbMIN9XEFJub/5
         X9EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792533829; x=1793138629;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=oiJsb2ENhg2Lat5WWUqDnx4kJNVMy/Qtqe/7sshNmdw=;
        b=Ep4PGBnwT1YSI9zG0hZLNNfEZSFEgf1cM2mc0xRnMeCeeFcW3bz3UNnzv1+cPVc15w
         QVPOX9qUcOb02iJ4NzmmSwXJKaYISEu7Z5nCwA1GuqCf8sRTXo7/LXyTwplKkmUmY1i9
         Wu2Bokgp6igtBrCUg+GQbNea8x5ZnDaoLChGtmSnkUb3d4f0zUP5++78e4uA2SRGT2Xz
         fHnn4TKfXroiBTvyk6mcJvJ8ZEDD5IyZBP2gbdux3mFf2npdFUr2YGSr4efapYBbeQ4l
         K0jg/WNTxsc2Kwfy6qrPxdhbhe3m/OuAaugS0Jeprz9hyoK4ZGp5+486cfPDVlnz2MEe
         vFcQ==
X-Forwarded-Encrypted: i=1; AKwUvBwyF2HdAt1M4w8jmspzIJXmKKyzdS3wFS3Z6GLvqepGlfvnS0YXlBqfnA/Kukyww/m1/f2iLKZYiVe83eXe@vger.kernel.org
X-Gm-Message-State: AFq9FYIEH0ySW35dZ/lLgEW7i0+0+t40ba741s+D9U6IPRwsufyt9Xiv
	+3UGl08zDqsukY3S+F4Y21L9bD+KxtOAaVNXEbVCZ21G1qbuQD/6iPaAktBCFIoRgbU=
X-Gm-Gg: AYBFou0kGxuFyXVeEPwGoZ056RRFcmBx+8K9vgkgW56FMAOAH/ROYgehTiiPCHzKWgc
	XonkjLB1zgudGO+YDX0YmqNZ94gsxaZQT9O/piyrFzCK/5lljFwSqK8SEFmK1q60g6eaJ4NBboY
	sds0SPswLd+Qa9CSFTc59BwTfxS4BBLXLxHTRqSQpG6xztUfR9NP64ilHHs3np7ANVjyrVxMimj
	epYAmahm3c2SZPXDM0oEGv2Aa0FYzWqclWD+q/z7zFzfL7LlV1NzhiO6QYOaAuOpNKXxX4NYWeF
	/PKbYt4bkIqmsMzK1sM8KYCRkKXbBxE2IQN8INmNtk4qQrfqixBszX5l9WF7vK+zNEhSr60r0/E
	gpCn8OGHhF6qPVfOfrNMPuT7X+ec7YYiF2TENWPqfDHi4CBol8MymjNbAukfJxvgkGUQ+ysx8Kk
	RSgFHLJ7n2QKP326F42fdNMBIxqAkJhRkbjCrUnlpwxcxIHvlDw7YtDc+73coAVcBdvirCN97X3
	0iBjYl50QTbOfxmtc2MRfAWn9RwQvFadJwO7XqzPkI2jzISh646RFXD6mkIn4yDF5j/lZaOj7SE
	xnJxC+SPloBV0Qvd68gB6bkX0p/BqhpHF+pCP1sy8EX5/IAbcBp8CnxUofV36D3DoQ==
X-Received: by 2002:a05:620a:690e:b0:93f:52c5:a32 with SMTP id af79cd13be357-93f57f7aff1mr111231185a.83.1792533828633;
        Tue, 20 Oct 2026 15:03:48 -0700 (PDT)
Received: from localhost (pool-68-160-167-46.bstnma.fios.verizon.net. [68.160.167.46])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-93f56ddd369sm92332385a.21.2026.10.20.15.03.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Oct 2026 15:03:47 -0700 (PDT)
Sender: Mike Snitzer <mike.snitzer@hammerspace.com>
From: Mike Snitzer <snitzer@hammerspace.com>
X-Google-Original-From: Mike Snitzer <snitzer@kernel.org>
To: Chuck Lever <cel@kernel.org>,
	Jeff Layton <jlayton@kernel.org>
Cc: linux-nfs@vger.kernel.org,
	NeilBrown <neil@brown.name>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <Dai.Ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>,
	Christoph Hellwig <hch@lst.de>,
	Jens Axboe <axboe@kernel.dk>,
	Matthew Wilcox <willy@infradead.org>,
	Jonathan Corbet <corbet@lwn.net>,
	linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH v7 0/5] mm, iomap, NFSD: stop uncached writes reading back shared pages
Date: Tue, 20 Oct 2026 18:03:41 -0400
Message-ID: <20261020220346.28020-1-snitzer@kernel.org>
X-Mailer: git-send-email 2.44.0
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

Hi,

Please consider this v7 for the v7.5 development cycle, so that it can
go upstream in the v7.5 merge window.

An uncached (RWF_DONTCACHE) buffered write drops each page it writes
once that page is written back.  A page the write covers only partly is
shared with the neighbouring write, and once the first of the two has
been written back the second has to read it back from disk before it
can write its part.  32 threads writing interleaved records to one file
on XFS (emulated 4Kn NVMe, 4 KiB pages), before and after 3/5:

  record  pwritev2() flags          4 KiB device       MiB/s
  bytes                             reads per write
                                    before   after     before  after
  47008   RWF_DONTCACHE             0.97     0.000     831     2281
  47008   RWF_DONTCACHE|RWF_DSYNC   0.99     0.000     601     1227
  6000    RWF_DONTCACHE             0.97     0.000     121      488
  6000    RWF_DONTCACHE|RWF_DSYNC   0.99     0.000      90      206

3/5 has the page cache keep such a page for the write that completes
it.  4/5 lets a writer that syncs its own write, as NFSD does for a
stable WRITE, complete those pages itself once the sync is done.  5/5
is the NFSD change that uses it.  1/5 reports the DONTCACHE dirty count
in the bdi debugfs stats, and 2/5 adds folio_mark_dropbehind(), which
3/5 and 4/5 use.

The prerequisite NFSD changes are staged in cel/nfsd-testing, through
ad42983b887e ("NFSD: add tracing for how direct-mode READ and WRITE
are serviced"), which was v6's 1/6.  This series applies on top of it,
and each patch builds with W=1 with no warnings.

1/5 to 4/5 are mm, with small iomap changes in 3/5 and 4/5, and are Cc'd
to linux-mm and linux-fsdevel.  If the mm and iomap maintainers are
agreeable, their acks would let Chuck take the series through the nfsd
tree.

Changes since v6:
- v6 1/6 dropped: Chuck applied it to cel/nfsd-testing as ad42983b887e.
- 1/5 to 4/5 (v6 2/6 to 5/6) are unchanged; 5/5 (v6 6/6) only differs
  in context, from its rebase.

v6: https://lore.kernel.org/linux-nfs/atbfEbgMU6UGkn2X@kernel.org/
v5: https://lore.kernel.org/linux-nfs/20261019150725.1507-1-snitzer@kernel.org/
v4: https://lore.kernel.org/linux-nfs/20261015233309.42999-1-snitzer@kernel.org/
v3: https://lore.kernel.org/linux-nfs/20261001045502.48381-1-snitzer@kernel.org/
v2: https://lore.kernel.org/linux-nfs/20260929231329.22018-1-snitzer@kernel.org/
v1: https://lore.kernel.org/linux-nfs/20260929173423.16149-1-snitzer@kernel.org/

Thanks,
Mike

Mike Snitzer (5):
  mm: expose WB_DONTCACHE_DIRTY in bdi debugfs stats
  mm: add folio_mark_dropbehind() to mark a folio dropbehind and account it
  mm, iomap: keep a partly covered page until an uncached write completes it
  mm, iomap: let an uncached writer complete its shared pages itself
  NFSD: drop a shared boundary page only once both WRITEs have written it

 .../filesystems/nfs/nfsd-io-modes.rst         |  17 +++
 fs/iomap/buffered-io.c                        |  16 ++-
 fs/iomap/trace.h                              |   3 +-
 fs/nfsd/vfs.c                                 |  99 ++++++++++++++--
 include/linux/fs.h                            |   8 +-
 include/linux/iomap.h                         |   1 +
 include/linux/pagemap.h                       |  12 ++
 mm/backing-dev.c                              |  11 ++
 mm/filemap.c                                  | 106 +++++++++++++++++-
 9 files changed, 257 insertions(+), 16 deletions(-)

-- 
2.52.0

