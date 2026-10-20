Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792500771;
	b=onhhKubswiCEI3ecQyNlKb7qthTE66QVQCY9PD7fpB4MX1STmvx1hVGTMvA7f6uBsb/e
	 ir3XccLCHOiy4B3nFEznK4V5ky4Li6TC38me2e/vJiinOn2au6TFVVipHTP8rzEmoOt4N
	 1C7/FkPyFN2e8m7R6X+e1VC7ORLLgIgAyV6yk/zZ5E6/m7/6gU1kQL8CPX1Mvf3XP7SGp
	 oBvfva4ulyCTUPmb4/5GsZFE8U4nH9BEmO2eYpWzVm8nogW2U25+vSn/Bo58mMYQLnuUz
	 VTbrEl7Xqgyg7TtPcgtRd8645A0twKbVzqeb4lmFBt46grfq9xugj6vCIPF50fMkvdg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792500771;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-Id:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding;
	bh=/4u1vmaSqipBM0zxv3OAa4p5s287MyrcxTiYmzVTx/k=;
	b=VkqsGyF/BMd6ZUJjzyJ6lA1aFzB4ki95f2c6m7MOknQytjxtZC9sGMgh6B76x3l97TSg
	 Yse3VhbxCHn1vbXGcR4i1VFFPwQ6yVxeoD2GAfqtG0TOGpFSF5q+tjXHgmIuEDNIuK0dQ
	 GCSmtxJcah50IZkpj6cbxxAjLQ4jZco1aCR/Z/yYJxkSRtm++ROyflqHm2Pvhq2UZwavA
	 LwRZrZvZ4nt3AOH1u+QPzo+ktt7OfueHsDPkmk2kIDYhI3rFsmUW1oVwycNc6hx/J+hTr
	 oPO8w0S/k24jXoRqmQOqqtn1D7SPc8lDAM1hcvt22s6bayFMcJ0anN2NozkAXSIYMow==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b="F/wHtwNC";
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=JA+2g4IK;
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93336606A32E
	for <linux-fsdevel@vger.kernel.org>; Tue, 20 Oct 2026 12:52:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 93336606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=F/wHtwNC;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=JA+2g4IK
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1792500769;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=/4u1vmaSqipBM0zxv3OAa4p5s287MyrcxTiYmzVTx/k=;
	b=F/wHtwNCHtpvA4YrgXHagstXJ8f9K3UgdPFglAVNbJxgmwNs7v0DSDIMMAD+En7DmITb30
	lxs06FvEHjb7hvirfnIxweyKuSMCb0ff7ZBtk/A9372BqtBN0GVRhPDTfYVOjiHjH7g6CJ
	txxsUZS0ws3P+byQbu2Lw1i04XcJNAc=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-663-4hF2TXDLOwKx2nZ-4YD25Q-1; Tue, 20 Oct 2026 12:52:42 +0000
X-MC-Unique: 4hF2TXDLOwKx2nZ-4YD25Q-1
X-Mimecast-MFC-AGG-ID: 4hF2TXDLOwKx2nZ-4YD25Q_1792500760
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-c41f85ee4a3so253887966b.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 20 Oct 2026 05:52:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1792500760; x=1793105560; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=/4u1vmaSqipBM0zxv3OAa4p5s287MyrcxTiYmzVTx/k=;
        b=JA+2g4IKo1TpGTA0gXPRIyNRyC4/A95C2h9G8LbDi/kNLz/YZijJfR9D24SfengdgI
         wM0HcIpHAyqvXQjr+YMZa6onoQl1o980Nys5bJ1ZaHZtCfUNsuGd7YOPkqIke4T/fUU0
         3ANrxBXbesNuVmXU6KRqqF6BY1uyrL/ksjS4zifrlB+35OnqgFGUh+tiCgcXOiU7YAmQ
         Xulq+HU4UtsHtdqEVe+enpi+SMk7FgHe/kC8uUXr/LzkmbiareBGL5pk0f/Z5rQpM2N/
         /6Ktt3H7FjKUqshLaJE1wXiZZ7BJvYAFWKSp+NvQOB1Q/KYQ6mhh8EoiMEjzg0hvC2U/
         ml3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792500760; x=1793105560;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/4u1vmaSqipBM0zxv3OAa4p5s287MyrcxTiYmzVTx/k=;
        b=wuMJZMS03MaxSOIaGXzILCAqQHBDTIb0+AH/OiNUk5t21crvh7H5SgJYnLK3a/R68k
         SrnViWFhP9WryqKGudtjLC/EPKNvYsAyha2TPHjO/lAdn+auWmLcraDSKKHutariVWr2
         QRY1qStgepz+d0YIsKNegpeTxGmh3itcC8cD7b6FQdP6suwPlb+AQwcF4YY1ERvDJBnw
         CSG0LoZnMVz3J+JHuv0aXA7P7tMU0MlERU0weigpShPlHiPk6NJQTqbs7g9xXe2YqPyg
         HZZRVQ3osP+E1nUHmTePSbm1r8EXkQG5yjghGsoO5ieNeu5Lhre5yVKOJ1HqkzL1+pQW
         EiSw==
X-Forwarded-Encrypted: i=1; AKwUvBwccONL2rzy9KIqE8vC7A0nTXvM1anpCHwNuqUBbqcuMu4L0tSZdv0YOTruEwqTqiGBRIPFTaNt54lhT+rZ@vger.kernel.org
X-Gm-Message-State: AFq9FYK0gyYUNP6fht9FPqztbFG/2iEdxvtZ1WTkLKDeGP3gDX+OHutN
	Gd6PIoTx5/P9a6rPPW6o3LmIb2JOfob2DVd4E+AwMwfl+gxyeDTzeIfwHaL14TRhZlZ/M8UUfCD
	hSdh/MX92RgGJGSU9FeGJ5zQrpxH0I/4k4TtuwnArl3hmbWhVRi1eKhbprv7EM6p9R9Y=
X-Gm-Gg: AYBFou3ZpjPUJL/zdyPXtcvNGu02ihQ2i21bL6SoTEpMnq/Iq4f2Z3IGRT9cNiqZRdU
	hTGzpzWLtOhoKP0FQobjJNnNpbpIJhaEbaj2qvmyDbtp9ABFlGvUgQtDg/bao/sHWhsZrVEnaXc
	LzfOjdx0JaIF5JS3eo2iiiZrcjHpcMn6/bMYk5pMvXOhRwh2zlm9VzDtgmcmthZ+ufFqKispmN7
	Cg/hbJuzSlzTie4hd6LHBbOUFx7djyN2vMnCgoXDC7fQFxRUe6HY+HP6wLUWrSdTP3wudHMf3Dr
	djX7R/foCQr19Yt/0mZSZPTsxeufE7MhNbU1O7ILv/b9QiOSoT011NIrXODT3+c9xwBSHiWgO+i
	5Yp7wf/wCt/wjMPySdvxqJex3rbcOmW9UCRT7tfCpPd/SLGWha8T5z/wQbgrHEcojMB/JfUu9Qg
	pTRAXKCoROChx7E4QjBaBRmYLrvaGN5kMjMdtSqwdmF2lv2aErafGgTWrCPaCro4m24AX2o1GJl
	f0=
X-Received: by 2002:a05:6402:11d1:b0:6b1:c5c3:9624 with SMTP id 4fb4d7f45d1cf-6b3a819086fmr6835222a12.22.1792500760223;
        Tue, 20 Oct 2026 05:52:40 -0700 (PDT)
X-Received: by 2002:a05:6402:11d1:b0:6b1:c5c3:9624 with SMTP id 4fb4d7f45d1cf-6b3a819086fmr6835205a12.22.1792500759746;
        Tue, 20 Oct 2026 05:52:39 -0700 (PDT)
Received: from cluster.. (4f.55.790d.ip4.static.sl-reverse.com. [13.121.85.79])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6b3c74eb8a7sm2982781a12.2.2026.10.20.05.52.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Oct 2026 05:52:39 -0700 (PDT)
From: Alex Markuze <amarkuze@redhat.com>
To: ceph-devel@vger.kernel.org
Cc: Alex Markuze <amarkuze@redhat.com>,
	idryomov@gmail.com,
	xiubo.li@clyso.com,
	slava@dubeyko.com,
	viro@zeniv.linux.org.uk,
	brauner@kernel.org,
	jack@suse.cz,
	linux-fsdevel@vger.kernel.org,
	linux-fscrypt@vger.kernel.org,
	ebiggers@kernel.org,
	tytso@mit.edu,
	jaegeuk@kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 0/5] ceph: support subvolume quarantine
Date: Tue, 20 Oct 2026 12:52:32 +0000
Message-Id: <cover.1792498351.git.amarkuze@redhat.com>
X-Mailer: git-send-email 2.34.1
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

CephFS subvolume quarantine isolates a subvolume while allowing recovery
clients with q/Q MDS auth caps to access it. Advertise support only after
cached data and metadata access paths can enforce quarantine.

This v4 combines the fscrypt symlink-cache prerequisite and the Ceph
quarantine series as requested by Eric and Xiubo. The dcache export is
retained. The generic fscrypt change precedes the Ceph patches, and its
Ceph opt-in is folded into the patch adding the get_link checks.

Changes since v3:
- Disable only the two fscrypt symlink-cache writers. Leave cache readers
  unchanged and update fscrypt_symlink_getattr() kernel-doc. Explain the
  held O_PATH descriptor / empty-path readlinkat() bypass and the allocation
  and decryption cost of uncached encrypted symlink accesses.
- Avoid unconditional snapshot RPCs only when the connected head inode is
  the target's actual subvolume root, identified by its nonzero MDS-provided
  subvolume ID, with a valid AUTH_SHARED cap from a quarantine-aware MDS and
  no local quarantine marks. A snapshot P/.snap/S/V/file cannot use ancestor
  P's cap to authorize access in V. Synthetic snapdirs inherit their parent's
  subvolume ID. Unknown IDs, other head ancestors, expired root caps and
  disconnected snapshots retain MDS checks. 32-bit clients also revalidate
  because membership IDs use plain 64-bit READ/WRITE_ONCE accesses.
- Wait interruptibly and retry unstable namespace generations or MDS
  authorizations in blocking cap acquisition and revalidation. Preserve
  nonblocking behavior. Track splice owners and reject recursive LSM hooks
  with EBUSY, including hooks outside MDS reply processing.
- Gate ACL cache suppression and namespace mutation bookkeeping on
  negotiated quarantine support. Invalidate older cached ACLs when support
  is first enabled and pair namespace tokens across that transition.
- Remove the impossible NULL d_parent guards raised during VFS review.

Validation:
Nine deterministic source-extraction regression runners pass, including
ASan/UBSan/LSan checks of VFS readlink and fscrypt target ownership. A warm
same-subvolume-root snapshot harness performs 1000 getattr calls, 1024 read
authorizations and 52 snapdir checks without an MDS RPC. A depth-300
harness completes 20000 blocking revalidations with injected namespace
splices without EAGAIN. Additional cases cover feature activation, ACL
cache invalidation, old-MDS caps, detached snapshots, epoch/rename races,
interrupted waits, recovery permissions and stale cap messages. The ancestor
snapshot regression fails on the earlier v4 draft and passes with the fix:
zero local marks and a valid outside head cap still require per-operation
MDS authorization for reads, cached stat and xattrs. Unknown IDs, non-root
head caps and 32-bit clients also retain MDS revalidation.
A complete W=1 kernel and module build passes with GCC 14.2.0 and the
normalized x86_64-rhel-9.4 robot config: vmlinux, bzImage and all 2233
configured modules, including ceph.ko and libceph.ko. MODPOST succeeds,
and the GPL d_find_alias_rcu export resolves. Additional W=1 builds pass
on x86-64 with ACL/encryption enabled and disabled, and on i386 with
those features enabled. All five patches pass strict checkpatch and
apply in order to reproduce the tested source tree.
These are source harnesses, not live CephFS benchmark results. Live
cluster, KASAN/lockdep, failover and snapshot throughput tests have not
been rerun for v4. Xiubo's v3 runtime results are separate evidence.

Remaining protocol limits:
Already installed snapshot PTEs still need server notifications to revoke
access without a new filesystem callback. Snapshots without proven coverage
by a cap on their own subvolume root, and all 32-bit snapshot operations,
still authorize each operation through the MDS.
Disable messages carry no generation, so same-rank ordering relies on
ordered delivery. Overlapping ordinary rw and q/Q grants still require
server-side auth-cap filtering; Xiubo reproduced that with ceph-fuse too.

v3: https://lore.kernel.org/r/cover.1792248177.33a6e2db0a.git.amarkuze@redhat.com/
v2: https://lore.kernel.org/r/cover.1792074165.git.amarkuze@redhat.com/
fscrypt discussion: https://lore.kernel.org/r/a01d0a297a3e174d21741a3ad586ce546327603e.1792081664.git.amarkuze@redhat.com/

Alex Markuze (5):
  dcache: export d_find_alias_rcu() for modular filesystems
  fscrypt: allow filesystems to disable symlink target caching
  ceph: add subvolume quarantine wire definitions
  ceph: record subvolume quarantine from MDS cap updates
  ceph: fail quarantined subvolume access with EACCES

 fs/ceph/acl.c                |  33 +-
 fs/ceph/addr.c               |  72 ++-
 fs/ceph/caps.c               | 317 +++++++++++-
 fs/ceph/crypto.c             |   1 +
 fs/ceph/debugfs.c            |   1 +
 fs/ceph/dir.c                |  54 +-
 fs/ceph/file.c               | 112 ++++-
 fs/ceph/inode.c              | 919 ++++++++++++++++++++++++++++++++++-
 fs/ceph/ioctl.c              |  13 +
 fs/ceph/mds_client.c         |  28 +-
 fs/ceph/mds_client.h         |  30 +-
 fs/ceph/super.c              |   4 +
 fs/ceph/super.h              |  99 +++-
 fs/ceph/xattr.c              |  54 +-
 fs/crypto/hooks.c            |  28 +-
 fs/dcache.c                  |   1 +
 include/linux/ceph/ceph_fs.h |  13 +
 include/linux/fscrypt.h      |   7 +
 net/ceph/ceph_common.c       |   2 +
 19 files changed, 1676 insertions(+), 112 deletions(-)

