Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=79.135.106.24
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795873363;
	b=bnifjtB6n/Eqf51Culwq509J4KlhGBLVbJRGjI//n1zKn88JdbPU26RYe9omXSPJ7qPP
	 YKkvlXfKuL+R/9xHDt8nH8F7jC5HnuZvcfqV/SuBXzkmsN0xZGZ5IP0Ou68dnbRMGsGlj
	 FopFPfyqL6uBlKY9eised3fqoDH2TJ2cK+qf03MC5j0muRy1izzbqCXe8NGa8/hvyrMCn
	 isuXMQNoI80x3birUeMz6F8RIRs17Sdu+ML/OfC98e9AN6QQT0rmRxmMT4RY0Zhj8NNuo
	 OP5YMnJGzGi5ieQQaMKb38yGIG2mjkwKSxsiQkescathLqJkvPemTrS2APXpoc3rsXw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795873363;
	h=DMARC-Filter:DKIM-Signature:Date:To:From:Cc:Subject:Message-ID:
	 Feedback-ID:X-Pm-Message-ID:MIME-Version:Content-Type;
	bh=/YrVE3nfHgtbOpjM9TAOhUwtbJ7UumHTjiT82LE/yJs=;
	b=WJcaeUHfAYYpMbEVHpmIoNFhIpwqDtDVlhlQ6K9AOzfyqrTtI8Q3tRfhP5xUFzS15C/j
	 e3sGLyhDJ1cunRRjBFtxCTMowwr4Kg6mTeIRbilj9yEbKwY8IxfNXORnBZi998HOPuATW
	 Ttua/31Zq+sckt6lZNKqOcuC5NS9foxCLOITTvHDvu6/lldbH2odsmVtgbTRoqvJVK3B8
	 yUUS/VN9Bn2882DuvJqCfh30/bt8f0dH+kUphgH7IQTbtZo+RU8rrYIC2peMUjU1bPAne
	 S0anSSd3uh9XEgbyz37U9ROBew8rk2LqCC7FBuoeorpBTwbbDQd6AgymCioIRspOHsA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=mzfr.me;
	spf=pass smtp.mailfrom=mzfr.me;
	dkim=pass header.d=mzfr.me header.i=@mzfr.me header.a=rsa-sha256 header.s=protonmail2 header.b=H9LurABt;
	arc=none smtp.remote-ip=79.135.106.24
Received: from mail-10624.protonmail.ch (mail-10624.protonmail.ch [79.135.106.24])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E96A7606A31F;
	Sat, 28 Nov 2026 13:42:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E96A7606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mzfr.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mzfr.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=mzfr.me header.i=@mzfr.me header.a=rsa-sha256 header.s=protonmail2 header.b=H9LurABt
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mzfr.me;
	s=protonmail2; t=1795873360; x=1796132560;
	bh=/YrVE3nfHgtbOpjM9TAOhUwtbJ7UumHTjiT82LE/yJs=;
	h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=H9LurABtvYdWc1fQJK28QW12br7JTpYXClDnFTO0NIwsyOLBPsHPFgiJ4pulB0Zuc
	 lEtI0cqUGi6H/aLonHrDhVwunsFwMSH9wu1DGWP/b159pOlzb8v7GxJGtXYGZmCdzP
	 WwOQJNn/0jPJa5Twg9BrQ9vVTf5ngFu7o9bdImUccRdm8x9Arvi948oaO25+6HF+9w
	 hZw2s7Nzz9g0Ms5/uZnRF4cFzW4x3987XqvgHI7HKbHjU+/qysRyjUPQZ1Yf73CuZz
	 /nrQM6hPx7dnUp6sjzURrbhiVsukUhNH/AoCPSNHMaCrtZ6rq38WT2BNKMFRrSclwD
	 sG32BDNpORE1A==
Date: Sat, 28 Nov 2026 13:42:32 +0000
To: Al Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org
From: Mehtab Zafar <hello@mzfr.me>
Cc: Jan Kara <jack@suse.cz>, Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] splice: handle zero-count sendfile to full pipes
Message-ID: <20261128134221.64884-1-hello@mzfr.me>
Feedback-ID: 37505322:user:proton
X-Pm-Message-ID: 6638043d303497b47feaf6c3d4eff58d37042df9
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature"; micalg=pgp-sha256; boundary="------37ff276189f2a11e75876853f9d2b251d4bfe4a94ae0bb1f337359ef042a05d4"; charset=utf-8

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------37ff276189f2a11e75876853f9d2b251d4bfe4a94ae0bb1f337359ef042a05d4
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
Subject: [PATCH 0/2] splice: handle zero-count sendfile to full pipes
Date: Sat, 28 Nov 2026 21:42:19 +0800
Message-ID: <20261128134221.64884-1-hello@mzfr.me>
X-Mailer: git-send-email 2.54.0
MIME-Version: 1.0

sendfile() sends to a pipe through splice_file_to_pipe() directly. For a
zero-count operation, that helper currently waits for pipe space before the
lower-level read sees the zero length. On a full pipe this makes blocking
sendfile() wait and nonblocking sendfile() return -EAGAIN, while splice()
returns zero immediately.

Patch 1 returns before waiting when the helper receives a zero length.
Patch 2 adds kselftest coverage for full blocking and nonblocking pipes.

This bug was found with AI assistance, which also helped
prepare the fix, tests, and description.

Validation on x86_64, based on vfs/vfs.all at 3857587d9d6f:
- baseline, three fresh no-disk/no-NIC KVM boots: nonblocking returned
  -EAGAIN, blocking waited until interrupted, and the selftest passed 0/2
- patched, three fresh no-disk/no-NIC KVM boots: both calls returned zero
  immediately and the selftest passed 2/2
- positive-count full-pipe behavior remained -EAGAIN, invalid output fd
  remained -EBADF, an
d the input offset and pipe contents did not advance
- W=1 fs/splice.o and full bzImage builds passed
- strict checkpatch was clean for the fix; for the selftest it reported
  no errors, warnings, or checks with FILE_PATH_CHANGES ignored. The final
  selftest run also logged an spdxcheck.py traceback due to missing Python
  ply; unchanged source and SPDX text had passed earlier SPDX validation

Mehtab Zafar (2):
  splice: return immediately for zero-length file-to-pipe splices
  selftests/splice: cover zero-count sendfile to a full pipe

 fs/splice.c                                   |  3 +
 tools/testing/selftests/splice/.gitignore     |  1 +
 tools/testing/selftests/splice/Makefile       |  1 +
 .../testing/selftests/splice/sendfile_zero.c  | 93 +++++++++++++++++++
 4 files changed, 98 insertions(+)
 create mode 100644 tools/testing/selftests/splice/sendfile_zero.c

-- 
2.34.1


--------37ff276189f2a11e75876853f9d2b251d4bfe4a94ae0bb1f337359ef042a05d4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

wsCpBAEBCABdBYJrCtpHCRBCkCzGpVLSJDUUAAAAAAAcABBzYWx0QG5vdGF0
aW9ucy5vcGVucGdwanMub3JnHtb5RJRsKbqCLlhaDuVo+xYhBJC8NTVod5IV
Rdc7/kKQLMalUtIkAAB61wf/d7CUc+fBkFY0amvSZbH85OHMc5m9CF16w9wD
2SiZgeDoPocKRCoEmKqVvCinFCSRuoIKRYFjor0vC7BEMXIzNLiFaKMoC9QD
Fd4+XLAcXOP+oVbjbizYGwrIMhV+NgFsKrfs7/8OaiGhlm40fPmi7Hi8+ONm
GIw8OYqfYArqx8x9C+XbzhQiSMcmJIN7AS4PVOtEynsCBsz59wAN4aglmSDo
iR1rQpP3BoGGK2BN0a8iJy2wWmjQdPupfuqEybeD6UeNuqWHgHVo3Likx6yt
3ldPl7dwL0v2EqjMVy2u+EcvXnf1GGpdpHuc9ryQ3mNlkc8dfKg9k48bJ5nZ
cIb6qQ==
=IZ04
-----END PGP SIGNATURE-----


--------37ff276189f2a11e75876853f9d2b251d4bfe4a94ae0bb1f337359ef042a05d4--

