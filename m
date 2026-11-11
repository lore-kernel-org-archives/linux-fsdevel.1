Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=188.121.53.25
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794440681;
	b=wMbitadmSIlvMzWdf3pw9GGQwexD855lQNKfMV76Nr9ZDHLwO+oybkoStP2i70MVeFmx
	 ZxiwCTkGC7Z4f7Ant4p6Y5CqSRES5a0QaKI+ytUJ/C/Kq89yQ3eKlGf9h69Sj9sNkMEcQ
	 Bln76Gv9APuc6ZtP/CjSc9+S3mJ+6oyRhrWfNQ2IiB93BopwapU2xQwkL7GfgmNzEIIYW
	 MOdVfgKlygU6hie0yvVpGuC1nQ9sGPvXBIzRZXTkmJ09TSYimRjl63RrHCQtf3XIydeif
	 YvTwjBivu47Wvwmx89D6nK0ueYf8QViJxR54d1D0QZV9CtJFpKO+cxs/+xof88NLk1A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794440681;
	h=DMARC-Filter:Received:DKIM-Signature:DKIM-Signature:X-CMAE-Analysis:
	 Feedback-ID:X-SECURESERVER-ACCT:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:MIME-Version:Content-Transfer-Encoding:X-CMAE-Envelope;
	bh=u+EO2KajcR8rLgZz+Ry4/vTQecm/jaLHNu7Gm6VV60Q=;
	b=reUEl+Y49zvfs4TwfCFlKV2wnIE8/+/6pyPHB3slaCZqHcsXTj7StAWNz78QmMgvniyZ
	 IwLtzzfLU6gu7UfBv1axdaAdrc2uWiJy0dparnjZQzkN2lTY88KZ+9V2g9b8pP0trSlDv
	 ln6lFi3PpL0WgAXm63kwxfg7L2ifFL6TrRJixsJx4Tj3W8w9jM/h9OnQkAJzXY/KMA0KW
	 sY13C3GB3M8d/Ib6P/8EWvYDFQEVfJyQRubgZI+u83sJPSojcybYbUzKs42l6MINTdp1I
	 5TwhdIApX0v/ZTdeundA+XzA4kpOWu4oRRDu+YphyVTLYau9LtY1najW4kjAm3UZ0CQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=squashfs.org.uk;
	spf=pass smtp.mailfrom=squashfs.org.uk;
	dkim=pass header.d=secureserver.net header.i=@secureserver.net header.a=rsa-sha256 header.s=secureserver2 header.b=rIKw6S7d;
	dkim=pass header.d=squashfs.org.uk header.i=@squashfs.org.uk header.a=rsa-sha256 header.s=secureserver1 header.b=BnD1cYz1;
	arc=none smtp.remote-ip=188.121.53.25
Received: from sxplsmtpa04-03.prod.sxb1.secureserver.net (sxplsmtpa04-03.prod.sxb1.secureserver.net [188.121.53.25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87419606A32A
	for <linux-fsdevel@vger.kernel.org>; Wed, 11 Nov 2026 23:44:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 87419606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=squashfs.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=squashfs.org.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=secureserver.net header.i=@secureserver.net header.a=rsa-sha256 header.s=secureserver2 header.b=rIKw6S7d;
	dkim=pass (2048-bit key, unprotected) header.d=squashfs.org.uk header.i=@squashfs.org.uk header.a=rsa-sha256 header.s=secureserver1 header.b=BnD1cYz1
Received: from avalon.fritz.box ([82.69.79.175])
	by :SMTPAUTH: with ESMTPA
	id RHz6xtxIpLwCURHzLxAFXZ; Wed, 11 Nov 2026 23:44:24 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secureserver.net;
	s=secureserver2; t=1794440666;
	bh=u+EO2KajcR8rLgZz+Ry4/vTQecm/jaLHNu7Gm6VV60Q=;
	h=From:To:Cc:Subject:Date;
	b=rIKw6S7dnpN0/AP4kxH0ijQhZwE0VCuV0N2du0IIzxwdiviAMRxCKACnE7cOlAtBN
	 w6gkVus1OqiA4ks1v2HI4c2wUheZBzCbMgnpha1z7sKpol/q9Aax32/LjB8wEqD/2T
	 6wBO6SWClRmgdeegQdnLiqBmdAyMJ3vayJciWO7Ito8GCyuColEIl1OpMCT3enTGLb
	 MN3She0lqqZGcJqg1/Ym6ubRigmrW5r+avv7ix3AcBrH5Jm0JOuJ7c3yjpidzTLTxA
	 1W/Cd0Qf+dpGjAVkZg5fnC17Q+fiDmPK8yq0h4acjDSEjTaBTiF9Len4zz9QHv6lYA
	 Iyg0d/6H5m4Cg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=squashfs.org.uk;
	s=secureserver1; t=1794440666;
	bh=u+EO2KajcR8rLgZz+Ry4/vTQecm/jaLHNu7Gm6VV60Q=;
	h=From:To:Cc:Subject:Date;
	b=BnD1cYz1ysFFcQgBJxZHfqF5+kNhntL299p7hFN8VdSW5nJMAclbc4a2Z4KHJ980h
	 6Deik4IXzLEQDLOHeb5FjahDbLYBJUbwFSKFfwer8YgisPO0j9LDAilgsDtfGlaFtn
	 xwZ+gXH1gk8s8WWCt/XND8y/P/IRsxNGVDgQFBFTICvdkDsYO8wDCC8oaADRGnLvWl
	 6NLN1EltoeZwwubLm5nPZPMR7ktMfTpC4+kIztQtW7+6dcVP/62fVeySlRKJxHATNT
	 5vmTRsLJRw4YVmkxM76mPEsNbeOk+YLathr1V0NqDWtBuWji6M8emMQK22u/RuqrSq
	 xGAaEZzvavFvQ==
X-CMAE-Analysis: v=2.4 cv=XZYcX455 c=1 sm=1 tr=0 ts=6af4fdd9
 a=84ok6UeoqCVsigPHarzEiQ==:117 a=84ok6UeoqCVsigPHarzEiQ==:17
 a=1KwyjEPoHUs1rspk:21 a=axh2pikBN2kqpKA8ZLUA:9
Feedback-ID: 85b9d5beff298dd9b5d1e668d4768538:squashfs.org.uk:ssnet
X-SECURESERVER-ACCT: phillip@squashfs.org.uk
From: Phillip Lougher <phillip@squashfs.org.uk>
To: linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	akpm@linux-foundation.org
Cc: Phillip Lougher <phillip@squashfs.org.uk>
Subject: [PATCH v2 00/22] Squashfs: fix a lot of AI issues and AI style issues
Date: Wed, 11 Nov 2026 23:43:40 +0000
Message-ID: <20261111234402.252354-1-phillip@squashfs.org.uk>
X-Mailer: git-send-email 2.47.3
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
X-CMAE-Envelope: MS4xfEMM73upIyMCXWr2Keg0UixUPiYj3YgtoNHIV9RnK7jGrIHGpTe6BbTnoPnfPaXajFBgrRXF1T6Ded/ohgwdEbt6eLWigq6XE7yfVUM/klKMZ3aBLZkT
 xwLHjrq1H7GUg3YrQHMZROcFukhB7dcJKsDyaDwbzEZUxbGCqpd09UMUorTjyhNmR/rIiuiqRgfVtqOljQ3ZLVhgpIeKjXSpto+TGDmPOaAziorqbA9H7+Ox
 AshPIJAg6Jaw4FQUZnMkUyryBOp0mfmct5IK9qlpQP7rZPTeEI1FLAHSqU2RpDwPcRMlQeRzMjDK4ycJbV1A0to3vSAVaFbEDTY6NW1QNLQ=

This large patch-set is inspired by the recent spate of AI generated
code reports.  Four of the patches directly fix AI reported issues, and
the rest have been found manually by a read-through and testing of the
code.

In all cases (except patches 17, 18 and 19) the patches deal with
over-sights relating to variable overflow, arithmetic overflow, variable
signedness or just lack of sanity checking of data read from disk.
These can cause the code to fail, and which could be used as a potential
exploit.  

Patches 17, 18, and 19 fix potential excessive memory use exploits.  The
code in question was written in the early days when Squashfs filesystems
were small, but with very large filesystems it could try to allocate
memory in excess of 4 MiB, and up to 64 MiB.   

The patches can be broken down as follows:

Patches 1 - 6 are preparatory patches.  They convert old fashioned
#define macros into inline functions.  These being typed make widths and
signedness explicit, and allow additional checking to be added in later
patches.

Patch 7 fixes an incorrect offset value in TRACE statements in
squashfs_read_inode().  This new to this V2 patch-set.

Patches 8 - 16 fix various issues relating to variable overflow,
arithmetic overflow and add additional sanity checking to prevent these
issues from occurring.

Patches 17 - 19 remove the excessive allocation of memory by introducing
caches, which limit the maximum usage to 4 pages.

Patches 20 - 21 are new to this V2 patch-set.  They deal with some
issues Sashiko reported in the original patch-set.

Patch 22 is also new to this V2 patch-set.  It adds an additional belts
and braces sanity check.

Patches 8 - 20 have reproducers which show how the existing code faults
can be exploited, in some cases which can allow a Squashfs filesystem
to be tampered with to make files readable by unprivileged users.

BTW checkpatch.pl complains about the '#' lines in the BASH script
reproducers. Let me know if that will cause problems.

 fs/squashfs/block.c            |  20 ++-
 fs/squashfs/cache.c            |   8 +-
 fs/squashfs/dir.c              |  91 ++++++++---
 fs/squashfs/export.c           | 146 ++++++++++++-----
 fs/squashfs/file.c             |  89 ++++++----
 fs/squashfs/fragment.c         | 113 ++++++++++---
 fs/squashfs/id.c               |   9 +-
 fs/squashfs/inode.c            |  73 +++++----
 fs/squashfs/namei.c            | 116 +++++++++----
 fs/squashfs/squashfs.h         |   9 +-
 fs/squashfs/squashfs_fs.h      | 101 ------------
 fs/squashfs/squashfs_fs_i.h    |   2 +-
 fs/squashfs/squashfs_fs_sb.h   |  25 ++-
 fs/squashfs/squashfs_helpers.h | 363 +++++++++++++++++++++++++++++++++++++++++
 fs/squashfs/super.c            |  96 +++++++----
 fs/squashfs/xattr.c            |  49 ++++--
 fs/squashfs/xattr.h            |  21 ++-
 fs/squashfs/xattr_id.c         | 173 ++++++++++++++------
 18 files changed, 1099 insertions(+), 405 deletions(-)

 Phillip
 ---
 Squashfs maintainer and author
