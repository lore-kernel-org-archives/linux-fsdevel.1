Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792528020;
	b=oA3rl/KRI/OUdszF6CojJTe8hEKGhl60QC41YoMRgY5rLFCvoeWsgIoMmruRuQlZehLU
	 mNl62Q0EUeYKwGDRU0zzVf4pcx5srw3fqSNaGReodn1rHP31Vve/xHdgtqljolqB6E6t7
	 C8exq2AWBHDqNirqoPcEInw9C6dCPzYVHK7on9sDDKUNh4yjG7G3mkuGwKhbVsgpJpwiK
	 pwqc7j1N4OrofO8DZtE7lIES7vF2dlbcajHfkYL7ptNQ8pbTMSbgCf6gRiDKC5GY+MZB/
	 aMge9A6lK5QP9SQIQfKXDWkL5f1w8amj8odA8Ekm3YT4rifD2TIQAjsG3Iomic8ET1w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792528020;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-Id:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding;
	bh=TW/jV95LOEvRHszhdNGhwpA/t/teGFEjQBs0Ama5dKM=;
	b=piD0IyN2eIZS61SX5hVSDgvYkSiIAIHzr+CkyH4aSP1jJJd5grYnTHihI/ycqz/NHkj4
	 As0xOAtq/V1t2XM2r2d+GmoLjfd3X3hjti1lyZvKmOgYY5zKgdRvYuMWqyMxlcw5VgFWj
	 AjbzqFVxjFkKcCqJcQbNTjoiF9yWG3lOQfS5Oy/e5YRjzc1aMziLJJAS70XJVX6zINz8V
	 UyP3zKPfQK3hskH1X5G38pkqMJsYJOz7p7aZaYDYxjPuaalId32Y0M/O/7DC4Pl7xErd5
	 ulz4ikQDqtqPvMuiaERY2MFCzXBgGS1A+YLyXHNbenF+eSLLDmK8o4hw9d1foFRPuTQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=fidoOPYR;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=VrtcOP4x;
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D57C9606A31E
	for <linux-fsdevel@vger.kernel.org>; Tue, 20 Oct 2026 20:26:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D57C9606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=fidoOPYR;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=VrtcOP4x
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1792528019;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=TW/jV95LOEvRHszhdNGhwpA/t/teGFEjQBs0Ama5dKM=;
	b=fidoOPYRcnWE1fwZT50VNa8FK+nW+xj0s/2eqMSuLrmI1NAH/m7U93OuKsnogSSi4aiATC
	Os5H4rU9PDpS+7+yquw7CGseCXxd2lf/ictl6EOiMjDElQdSIwb3NdpczbaTozIzWPJIch
	/8WmoyGQC2romsg2BOyLAWtlc/mhWOY=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-103-15gwOjijPOWMxH3DcYAAOw-1; Tue, 20 Oct 2026 16:26:57 -0400
X-MC-Unique: 15gwOjijPOWMxH3DcYAAOw-1
X-Mimecast-MFC-AGG-ID: 15gwOjijPOWMxH3DcYAAOw_1792528017
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-93f2c0e6653so9839085a.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 20 Oct 2026 13:26:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1792528017; x=1793132817; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=TW/jV95LOEvRHszhdNGhwpA/t/teGFEjQBs0Ama5dKM=;
        b=VrtcOP4xrD8B0H1AV7LziwybV4me3HIJbjpIbxswaiuviEhDh470+Aezas81I3jLnY
         cdN+dzwoJyK8kMkCQed9YKPzFJvHNWH1z/O3wiC2zmEpDv1hUyrfRMDo0D55/zD92Fql
         fRV5CahB8PbLzmocNZBR7Uz0rRxzOeg3BrgkZcjDFFg6dIOB6mxP7qxue3G/gPRWJZOT
         c1q1EtomS5GnvRvtO2Pehe1AJhlqPsFsU9gxayKfHi8UsHefcbnzbZiorPy84W1OH7VC
         Dd2ODASXb3r+8DHKvhAKe+IgcB3M/dH5KZdePOzSKb/6IjNXefJR3LOb5IXHjKd59cdo
         ehgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792528017; x=1793132817;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=TW/jV95LOEvRHszhdNGhwpA/t/teGFEjQBs0Ama5dKM=;
        b=WmMv77xbtK8z11H4tzqQexk1Jqe6a21Ml/pBAE0zJo8defoamVuUnuFN6IRSaLcS0T
         LTgTXuro+MY2F/na6qnsDv8sEaCKVONNQIMYs/VB5tFAbwA4REHjj/3LDZjP0oSCL4oi
         lPDX34aQCxPcM7/Kz6MHzTkPqMCYkjiG1BsUx6YRRJsrsY2mctDvEPC0d9MbU3ypRl6t
         QpI5upeyZX9Vz9CxDNnKrgG1d7Y9kFZRKwiY13iOBT8AOy2WEwhXqgk722NavrkcsOkw
         uUG59QIpaaIJw0K5pUWJenS7sJihIRSz/i/IuAskmt768FDHU7eWEPYocCbeDmj/oqAF
         GlGw==
X-Forwarded-Encrypted: i=1; AKwUvBxtF0JXNtwB4QR33acDt/rNhmcMpkvu5lUf7dw8ZI9biC8cUAHIAbPkdnNDHNKUSHBEMNHXdP6YU/Bf+Nld@vger.kernel.org
X-Gm-Message-State: AFq9FYKBquyhSNeIvSYo50WHXPhXDurEQk2jPJNt2n7QgA2OtdsAnqwZ
	kN9ddKfaDLgsMXHgjebzjUwtMkmzWciI4cCU9x6Ht6jvKaBZud79GPebz+dwinL9fVkl2xKAMs5
	gE+nnRfhCPiIrrMV3Sfhrs1vAS4tlTUapPmHTJ3Tkx+zALXrXXi+ViaUG7eTbAY5SN5M=
X-Gm-Gg: AYBFou1QccD2kmuBqLOSjY0oi+HcmPvd9sx7eOV7hKD2hpYPHNFCjVw9vxO1yWoT2Y8
	DoOJGgT8bQNO3FasYu5BL//N/O3TpTIJqaVcp9yoE+nUtNrjJYNqkSOMoEH9N/2pFUCBBiul6W6
	ZtyYWoaJuSYkv3gZHb+X8+Gw5ZXf8ZlKBJbmCYUxdhABxhuu0jbMnwXOW0RFYtb55HUH3k1ReKo
	dVV0WzHq5V5+/erHipDzb+OVKuOpCvOpg2mOtMwVZeZ18TQ2Ii4RGuouftegsq9AxxasNMbjIWx
	+RTwh2YFaFj6vGBurDicYb4hjF2MCRpfSORw8hMz3FgGIl4iZy+fn54vEnR9sf8mkjEO8o0Qo9g
	BYPSP0zDW3w66LJ2aih0kgIzR6+Tri67sgaWsljPYiaOiBkBPWtlYFV1I81bpQCGkXTjbe9FZsf
	Sf/FvgKtQImKRRLrkinoRbHsEtrMraRrb6k2/Bo0xS10Z6sK+fW2BfhrNUmtASzCAhy+r1nkk+H
	BM=
X-Received: by 2002:a05:620a:838d:b0:93f:116:9873 with SMTP id af79cd13be357-93f57e404afmr79933485a.7.1792528016759;
        Tue, 20 Oct 2026 13:26:56 -0700 (PDT)
X-Received: by 2002:a05:620a:838d:b0:93f:116:9873 with SMTP id af79cd13be357-93f57e404afmr79929285a.7.1792528016283;
        Tue, 20 Oct 2026 13:26:56 -0700 (PDT)
Received: from cluster.. (4f.55.790d.ip4.static.sl-reverse.com. [13.121.85.79])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91c10a45336sm7461436d6.3.2026.10.20.13.26.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Oct 2026 13:26:55 -0700 (PDT)
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
Subject: [PATCH v5 0/5] ceph: support subvolume quarantine
Date: Tue, 20 Oct 2026 20:26:45 +0000
Message-Id: <cover.1792527529.git.amarkuze@redhat.com>
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

This series is based on the testing branch of:
  https://github.com/ceph/ceph-client.git
at commit ed0502cb11f84fff29f374238e526ae94d9bdfde
("ceph: validate encoded xattr name lengths"). The repository
defaults to for-linus; the base is available on testing.

This series combines the fscrypt symlink-cache prerequisite and the Ceph
quarantine series as requested by Eric and Xiubo. The dcache export is
retained. The generic fscrypt change precedes the Ceph patches, and its
Ceph opt-in is folded into the patch adding the get_link checks.

Changes since v4:
- Add the missing base-commit and identify the public testing branch.
- Require a live, quarantine-aware AUTH_SHARED cap for cached head
  metadata access. Without it, ask the authoritative MDS for each
  operation, including cached stat, retained directory replies and
  encryption-policy/nonce ioctls. A successful reply without a cap
  authorizes only that operation. The fix is folded into patch 5;
  the first four patches and public base are unchanged.

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
Ten deterministic source-extraction regression runners pass, including
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
head caps and 32-bit clients also retain MDS revalidation. The new head
coverage regression reproduces the cached-access bypass before the fix
and verifies denial after it, with missing, PIN-only, expired or stale
caps. Repeated accesses without a cap each request authorization; a live
AUTH_SHARED head cap preserves the zero-RPC cached path.
A fresh complete W=1 kernel and module build passes with GCC 14.2.0 and the
normalized x86_64-rhel-9.4 robot config: vmlinux, bzImage and all 2233
configured modules, including ceph.ko and libceph.ko. MODPOST succeeds,
and the GPL d_find_alias_rcu export resolves. Additional W=1 builds pass
on x86-64 with ACL/encryption enabled and disabled, and on i386 with
those features enabled. All five patches pass strict checkpatch and
apply in order to reproduce the tested source tree.
These are source harnesses, not live CephFS benchmark results. Live
cluster, KASAN/lockdep, failover and snapshot throughput tests remain
pending. Xiubo's v3 runtime results are separate evidence.

Remaining protocol limits:
Already installed snapshot PTEs still need server notifications to revoke
access without a new filesystem callback. Snapshots without proven coverage
by a cap on their own subvolume root, and all 32-bit snapshot operations,
still authorize each operation through the MDS.
Disable messages carry no generation, so same-rank ordering relies on
ordered delivery. Overlapping ordinary rw and q/Q grants still require
server-side auth-cap filtering; Xiubo reproduced that with ceph-fuse too.

v4: https://lore.kernel.org/r/cover.1792498351.git.amarkuze@redhat.com/
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
 fs/ceph/file.c               | 112 +++-
 fs/ceph/inode.c              | 954 ++++++++++++++++++++++++++++++++++-
 fs/ceph/ioctl.c              |  13 +
 fs/ceph/mds_client.c         |  28 +-
 fs/ceph/mds_client.h         |  30 +-
 fs/ceph/super.c              |   4 +
 fs/ceph/super.h              | 101 +++-
 fs/ceph/xattr.c              |  54 +-
 fs/crypto/hooks.c            |  28 +-
 fs/dcache.c                  |   1 +
 include/linux/ceph/ceph_fs.h |  13 +
 include/linux/fscrypt.h      |   7 +
 net/ceph/ceph_common.c       |   2 +
 19 files changed, 1712 insertions(+), 113 deletions(-)


base-commit: ed0502cb11f84fff29f374238e526ae94d9bdfde

