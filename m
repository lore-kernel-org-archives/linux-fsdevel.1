Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.70.43.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795873367;
	b=BZT4u3bct0tnX+twfFJZyjhCD8H/FumRnQ1pvak31q8JQMog92y2hvVYtgIWNIykwJWU
	 KUk6aVAGNsf4abOTShky+ehxksWu6UE1Q0kXXyjHC5YPDlu1g4+qtXiVKtn07HQ1Gb2zY
	 J/JQc35RfYUwUY26U1sH89hlgXv8ddU29EGakvtpK84VvNKWaRyH4dCg+WpVFDVnvgmKO
	 mJgvE54VMidakLPnrqrnlHcZLQq1ghZmSYWvKkRMG3Wr0Mdcnx8MjMGJ/vfCas6jsJdcO
	 0+GLbzazCZ+RWDRebC4I6y6z+HXqtk5D/PvIds6QBp8dN0eWbvjsi3wn5UwZPZsm99g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795873367;
	h=DMARC-Filter:DKIM-Signature:Date:To:From:Cc:Subject:Message-ID:
	 In-Reply-To:References:Feedback-ID:X-Pm-Message-ID:MIME-Version:
	 Content-Type;
	bh=nQoAOzprCWfZA4oj6UvxUYwDg5wgrLYjKsw078gb2f0=;
	b=DSuZ8lF3S8N+7ti6f96q2qErOeyXD/oIgzbBPmXJSDLmS01v1DhuCETS5Y2OKQNnHT7F
	 XwVmiGCttUfWU2qgFSbgnAdnS/ToflFUGqmFsJLQDYkfJfGmTDJiyR9ownRMw8/2GOJ0r
	 p7f/b9yjRGWS2UK6+YIF3FIGUHduBy6QxaoIG/39qI/b1pIpsBtbqGD16UoYeoG2fKzoC
	 FNtFwMBuS7MxgFwIsVcATbndOAxinHQvY3TW4JTvb2PXRUpAc4+3ijx2tFJJApzhAbVXd
	 749r8oP3RnKsbfsIeQnc9mUiKivSBIcf67qzHntWZz2oOX+VfDzGx3FqGVaBGrDX2Cg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=mzfr.me;
	spf=pass smtp.mailfrom=mzfr.me;
	dkim=pass header.d=mzfr.me header.i=@mzfr.me header.a=rsa-sha256 header.s=protonmail2 header.b=wgYKblGC;
	arc=none smtp.remote-ip=185.70.43.18
Received: from mail-4318.protonmail.ch (mail-4318.protonmail.ch [185.70.43.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0202606A323;
	Sat, 28 Nov 2026 13:42:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F0202606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mzfr.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mzfr.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=mzfr.me header.i=@mzfr.me header.a=rsa-sha256 header.s=protonmail2 header.b=wgYKblGC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mzfr.me;
	s=protonmail2; t=1795873365; x=1796132565;
	bh=nQoAOzprCWfZA4oj6UvxUYwDg5wgrLYjKsw078gb2f0=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=wgYKblGCtIafcEqc+dxNBL52USCYvfeA1Wmrvpna+6wtwkL15w6jkS5/bPdbmhxRY
	 16W2gSiJ/vbcGqe3wVS35Hf5YNPaJWz0RqFmCG9FkDTsEUckFFvE4pyyrrsb064xjv
	 UIy2q8amWXRxpyoHh6Eht8NUvNdBIac8dgeAPjPEveojcgffpaURVT3JwSaE3c+zeR
	 mxBnNGi9MIRgOwYRWzLeVro45yoLsnQtE7BDAkn7uIMfPyb7JewjNKDKs6oKUy4ZV6
	 W1+cvspxEtMx1tyWQzTbvgXDbrVyHUUvd4qfBXV94iUQCyj04McluyvlO9m14GqW6T
	 T18qbg1DqUzrQ==
Date: Sat, 28 Nov 2026 13:42:40 +0000
To: Al Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org
From: Mehtab Zafar <hello@mzfr.me>
Cc: Jan Kara <jack@suse.cz>, Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] splice: return immediately for zero-length file-to-pipe splices
Message-ID: <20261128134221.64884-2-hello@mzfr.me>
In-Reply-To: <20261128134221.64884-1-hello@mzfr.me>
References: <20261128134221.64884-1-hello@mzfr.me>
Feedback-ID: 37505322:user:proton
X-Pm-Message-ID: b31e0b54b2e7a00b792d7449a2cc6be49a14b777
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature"; micalg=pgp-sha256; boundary="------520483031699f09f7999ba80600ea9817aa6409337e1b91ad82e43eae5f09e88"; charset=utf-8

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------520483031699f09f7999ba80600ea9817aa6409337e1b91ad82e43eae5f09e88
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
From: Mehtab Zafar <hello@mzfr.me>
To: Al Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org
Cc: Jan Kara <jack@suse.cz>,
	Shuah Khan <shuah@kernel.org>,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] splice: return immediately for zero-length file-to-pipe splices
Date: Sat, 28 Nov 2026 21:42:20 +0800
Message-ID: <20261128134221.64884-2-hello@mzfr.me>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261128134221.64884-1-hello@mzfr.me>
References: <20261128134221.64884-1-hello@mzfr.me>
MIME-Version: 1.0

sendfile() to a pipe calls splice_file_to_pipe() directly. Unlike
splice(), this path reaches wait_for_space() before the lower-level read
handles a zero length. A zero-count sendfile() therefore blocks on a
full blocking pipe and returns -EAGAIN on a full nonblocking pipe.

There is no data to enqueue for a zero-length transfer. Return 0 before
locking or waiting for pipe space, matching splice() behavior.

This bug was found with AI assistance, which also helped
prepare the fix, tests, and description.

Fixes: b964bf53e540 ("teach sendfile(2) to handle send-to-pipe directly")
Cc: stable@vger.kernel.org
Signed-off-by: Mehtab Zafar <hello@mzfr.me>
---
Tested on x86_64 against vfs/vfs.all at 3857587d9d6f in three fresh KVM
boots per kernel. Baseline: zero count returned -EAGAIN on a full
nonblocking pipe and waited until interrupted on a full blocking pipe.
Patched: both returned 0 immediately. Positive-count and invalid-fd
controls were unchanged. W=1 fs/splice.o and
 full bzImage builds passed;
strict checkpatch and git diff --check were clean.

 fs/splice.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/splice.c b/fs/splice.c
index 5397ded643a7..afad10adf138 100644
--- a/fs/splice.c
+++ b/fs/splice.c
@@ -1239,6 +1239,9 @@ ssize_t splice_file_to_pipe(struct file *in,
 {
 	ssize_t ret;
 
+	if (!len)
+		return 0;
+
 	pipe_lock(opipe);
 	ret = wait_for_space(opipe, flags);
 	if (!ret)
-- 
2.34.1


--------520483031699f09f7999ba80600ea9817aa6409337e1b91ad82e43eae5f09e88
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

wsCpBAEBCABdBYJrCtpQCRBCkCzGpVLSJDUUAAAAAAAcABBzYWx0QG5vdGF0
aW9ucy5vcGVucGdwanMub3JngyYqCLjelYxq07mrcH9vaRYhBJC8NTVod5IV
Rdc7/kKQLMalUtIkAACjrggApFhCjhmLIvF8ryb96f1d/CDnxxoPbwDVAaDW
YC2I2ZbbnAAgM5cWLsGlZk1pEFYBzA0H13wgSc+8DaOzI5DOKAFCsz/oUgFq
wf3XUkgsUyB1wT8gmg0+eQSzyrYG74yXCatsjti8Y9Kom2/bS2VGVkxIUzc6
DdTHDJil/160jeSLDIY39dz1/4aD1TRO59y+OHdqN1L08b/mgJNFTFZhNxuU
46gORPS6VsI793NTAWk6sodgLTuL00E0f16yn1pJk4QRQ1Hf7aT7aGPywPx6
M36zU5dngQLLaJVSLR3ZsMi1uisF72GP388L5eGIutQ+34UwBPv0j8+JYsiK
WJozww==
=urW/
-----END PGP SIGNATURE-----


--------520483031699f09f7999ba80600ea9817aa6409337e1b91ad82e43eae5f09e88--

