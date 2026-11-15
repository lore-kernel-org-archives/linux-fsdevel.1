Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794701655;
	b=mmqzdde/dl0T1kp8Lr/Hp1LPBfrK+RS6WbICu5q2rPXCLVJRBNeRMEQgfQO7RtAMfNCu
	 Wq5D8mcGl4RFPynQqAj9pBAlftTBSR4jxAX7+FKs0TqOoHgMynk1SdCNxJneaMsxlCgHe
	 JhP0GQrushiAPCuGV4miOrB2CE2iwjLvlFq/N1q7Amhpp5RT49+H3zSJjgpP/rT1LOoVp
	 8NGskGddGuLnayy1oqF/q96JcL2TFhyGGrPwU0aJC6bQzmp5kES9wdmBCzFBK054SO7EJ
	 WSSAzWtO4QOzT9mrOU4NfY5XMN/Yc+njTcjcY7uaC0q0wvvzDjcCEVQDR2+YZK4od9Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794701655;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=BowdHmWbI0HF2cyBE1LmXoTTFShzBjfQ5Hp9NB3N4DY=;
	b=BfrK2TJZ0KrDiG1xeETJcwqS3SYAMDs2Ur7iq/UDNYyVwoO91iNr5m3/tKxeOKqYjG/E
	 0I5Wc+nYqu/jBUA12X+t1612cXTliQvyDag3wD3zhf3+0vabKG9n75xB2THXkCFoGsX6K
	 Ugx79OFtMl9EnHWLS9ENJRaB1zZ6yyYiV7CTiYRnxSqXqPOQupAlajTGc0Y+y6WZ7EJrR
	 GpavZSj3o9vq18sRF5d7swkQajig+QxZ3+QDAY89oKFzHqkUzR78scE420JBz0d3EFa4/
	 44bzT6eMgrSHTdmSGYnPQD1e+f8vx/C9gL3HUaCXGA1G7FGlSKBvOAViLVS4SRn2AyQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ysnHlMCW;
	arc=none smtp.remote-ip=209.85.128.47
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89E7C606A327
	for <linux-fsdevel@vger.kernel.org>; Sun, 15 Nov 2026 00:14:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 89E7C606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ysnHlMCW
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4ba013938d7so26031395e9.2
        for <linux-fsdevel@vger.kernel.org>; Sat, 14 Nov 2026 16:14:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794701653; x=1795306453; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=BowdHmWbI0HF2cyBE1LmXoTTFShzBjfQ5Hp9NB3N4DY=;
        b=ysnHlMCW+cjJVg2dhZMlQ8eO4cE1Ynwiw8m2ecVAhDovnJWse88BNQ17S+IpXzg0fj
         B8098OeXf1hGGjC4dwNlQ51O0gmoUL1oY28zwe/zn8u4nQTqk94YClA1Tsi7K1N3E5eA
         T88cOEZci6DnJoFK7UODNSYT5krNE2r+C3WDezPuySuF2sNc/CmSRVzHpKWvgdumfVN8
         foxfxE6lphari5tDBs96CDA5jgdQ2kBuWnk8PvkZ4NdUyuvlfHhnsDbpEDEnExpY+R21
         7GkrJLoosfplhd2XkgGMPbdZEmzIXjFp57EEaT/c0pZanl69RgctUXu+nuyCRMwYUxKI
         GpHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794701653; x=1795306453;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=BowdHmWbI0HF2cyBE1LmXoTTFShzBjfQ5Hp9NB3N4DY=;
        b=VWUZnKkuRP8oIBNaK4OxKx5wJzCrUDJKrUxUiEtsGBMuVk50sOXnsGAEnK53BCCsSa
         5CCx7UWZSTDWtUTu5ynslLlgTgHYRMUv+ORArE0R4C69g5d18es7fFtWNy5lBqnrhhuU
         5CuSJSokwAPM2psi7gfbFGayeTJPD4Ck+2ZTyXsCTavCvNKM85SjnjSTyGfWgeCPPkYA
         Q6SxjK+6Bm29QfOrTa+KQzgm0JHXCT+HD4Zks0SW9n+ICwEXz1hwL8yAPKH7WYgbxtHw
         7UkwwY2aOokhFhAQ5URSWbYykFzmCFbcdy8ep3IpujXRb4ZXaU49G8xx/SNaluT58gz7
         IXXw==
X-Forwarded-Encrypted: i=1; AL+hErGIP8G7trN2sMCOGo8zBfpPxYLw6YcNXEfW6PFj/tpzEcOeb0E2j/EAsAkH0Do+neP/nil+APTZDW5HgivA@vger.kernel.org
X-Gm-Message-State: APuU4Z8otIz+gtpTcgFRUA/cwtwCVnU8BbOe7EGRTzpisL1dQgpudl0j
	tcZM1XjohJuYRX4QLiuYzu0TWnGiHGwFS/V+n9RgGOPzJrlDXS1Z1YZs
X-Gm-Gg: AYBFou2vkyAHKphFW2g1igzSC0E8Ux4/E3ovNgyrMLXoTffxhyuEI2LyIld3917dlk7
	Ue/K0KsG16QRmozmf3OEE9Zi6vUMxVaJSzMtFR2cKHV4GStv/QoSHjZ8HooBoTMmQB3z04+vWWM
	iwcfGEtxs+6CjaogvpnCqtsYueakxEpnRMbSM0wCdLFDox+/cVu8WrngyP+OiAoBVAS51U4ofs+
	zocGXf9NifHeXk0NELWpS/DqP6eG0WkhciD+5nTkQ723qu4ZJPt9ohyAEZ1mtKPVUNl1z43JKCq
	HqaItfn1DbDaXjV6cS6f3H3lDED6FBxuXHxSRdwvPZFCQCkJLdufla4z+/rAGd6NUQ6MDfqWr78
	92apHaGIlLFsY9SlHzZ6Xn0SUBvw1F3axZXGjJsKW7vc5i3fO0wJ9cO9kfga1UIaf4qq9VXKYv6
	gdokQSxJM/sz1aTHPtFq2bqb0u4o4ec2u9UZonMT9lmZ+Q5MnUtezlDsNZnbPOwicC1eDyFt+ke
	bXclZ9mke1M695StGuXK1DtVwPHuyyf37wpFOunBTesUdyPTTN7g0g/O6nJj5R5TH5aa30mr9Xa
	kLFcEpa/p4KiPNuPxQiZWG6Ug2mft50kFxuN6VZth6eoYxWtdB6wUuJRsm30UQqkViz2EQZ/OCO
	JTMfR6U8laiE=
X-Received: by 2002:a05:600c:46c9:b0:4a3:d327:6ed with SMTP id 5b1f17b1804b1-4bb55a5fdf6mr148913485e9.17.1794701652783;
        Sat, 14 Nov 2026 16:14:12 -0800 (PST)
Received: from mohamedali-HP-EliteBook-840-G8-Notebook-PC.. ([197.18.115.238])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb55ae4414sm177925125e9.9.2026.11.14.16.14.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Nov 2026 16:14:12 -0800 (PST)
From: mohamedalibouhaouala@gmail.com
To: willy@infradead.org,
	jack@suse.cz,
	corbet@lwn.net
Cc: skhan@linuxfoundation.org,
	rdunlap@infradead.org,
	linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-doc@vger.kernel.org,
	Mohamed Ali Bouhaouala <mohamedalibouhaouala@gmail.com>
Subject: [PATCH v3 0/1] docs: filesystems: update VFS locking documentation
Date: Sun, 15 Nov 2026 01:13:33 +0100
Message-ID: <20261115001334.23026-1-mohamedalibouhaouala@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261114235426.20408-1-mohamedalibouhaouala@gmail.com>
References: <20261114235426.20408-1-mohamedalibouhaouala@gmail.com>
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

From: Mohamed Ali Bouhaouala <mohamedalibouhaouala@gmail.com>

Apologies, I accidentally sent v2 instead of v3 in my previous email.

Please disregard the previous submission. This email contains the corrected v3, rebased onto the latest upstream master and including Jan's Reviewed-by tag.

Thanks,
Mohamed Ali

Mohamed Ali Bouhaouala (1):
  docs: filesystems: update VFS locking documentation

 Documentation/filesystems/locking.rst | 18 +++++++++++-------
 1 file changed, 11 insertions(+), 7 deletions(-)


base-commit: 23c62304dde29abe92013d85910d03a77dada35d
-- 
2.43.0

