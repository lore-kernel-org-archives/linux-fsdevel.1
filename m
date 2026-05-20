Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CACC285050
	for <linux-fsdevel@vger.kernel.org>; Wed, 20 May 2026 08:42:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.180
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779266543; cv=pass; b=WsL89GBpk28ktN+FfzFDDrq2ggy/i5uiQ3f80XUQAtuBFkwb+LEZ6qouBoR6GzJAPlwEfdRc5LwuTCCF2LN3vPzrD9Y2CzENhGQwmdTVShmDjuyALw4vSWAnfcqUCT0zrzaS3PXjLcbJCG0YbldDIYqQOiaOr+8EDAljJBXdVQs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779266543; c=relaxed/simple;
	bh=1hS0PDSrIk78t1eXCsL5SyXcGby/9NID8KVnMHtzils=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=pZTXEAPFnCyf+11Fv/ZoTWecnwXrsbew2OyUXF20BQLimCIeI3ZmYkuWoy2UOdyAyK7VP2SA7/ctHJXnIEp6c/SzKmP2Q0bYR52zvXZ6PLdehC0gLZ0cbNckKhX8UyHBa7ndLegW1D+4yq4bCX/K4WQBWGSTeIgFrr7KgN3nlm4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LKBFVNWW; arc=pass smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LKBFVNWW"
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-38e7d983f79so45841301fa.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 20 May 2026 01:42:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779266540; cv=none;
        d=google.com; s=arc-20240605;
        b=TQkcONpGc3uChHj8wZApEvSECv8hB0FNp1XgOd3GE6gd+7G5F3xsq+fqRWWEQK765f
         8K7+S1QNz2QQAnp7rAm5WW1mkWObAhxTX4Lz8IyRcviGCzM7Add87Cd+k7z09p261qUf
         Eo0/XolU8PH7dfWNd7x2No+LHy9CGWVicmMOo4+v8sqdy7bGBc4unygR6zwUwbztJvrJ
         f54BUuCe7HTY8iupFTcIrNa0XHR1krkkWTICIxZqSu7n+hhwkOSpqiHY9T4sBs+whbbY
         6PNYemd6n0NKGkX7aMuAvOAq89Ljn+sepejqsMPrGYN1EwXVH+dwMu/XBWQkVUEj6But
         mxsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :dkim-signature;
        bh=1hS0PDSrIk78t1eXCsL5SyXcGby/9NID8KVnMHtzils=;
        fh=on5so1iZ1tYm751VXv8x5u+l+XerJy9A4qWb/XOx/D0=;
        b=bg3v4urVrZPTqBoHfV2NDfYm3+NihXPL5BeULpm3xESq2HsxwJZNyXJSHk8Cc41SZI
         Pz4sd/+vIRcKUZvipzOp6ZETHAzzLLoZDS9JWJ6788pcol+50mAapb26eXa59j1ONLeE
         g9jxd8/wpsKBmjIy3KgMKGg3ez4iIgCefPC9ZZIgASpRpFY6q5Ip1ZIesW6xcvcwzQ/R
         6509cDLXwldnVyBiJrKB24aSy+tQLi16YM1jKlfbAxJcP3Pow3wfkaGFNtIDxHhnlqzN
         Y8cjmjqVGyJljZPtGntTWci9Ibyr7xfK6aWcWmn988gTPitsIdsz1+l/ypCglQVEqE+c
         2RRA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779266540; x=1779871340; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1hS0PDSrIk78t1eXCsL5SyXcGby/9NID8KVnMHtzils=;
        b=LKBFVNWW6UaLZjr7vC7He7FaDJnA9I6qKr5LqiT+I7URiMDjcRSWFt5TiE0AZZL8Vb
         W+rKHZ8F3e/2CpVeP+vB0x7leXlWAogqTY6lmoFgKHIa1Dzq4HPTYDr2S1XdQKIkAvzr
         Yg2mmBKoxtJ7fzqBAeNBNiXYfaZP/DitlfsafAWcDqzKIZ+jStKFGvLtUWSJNQAmKT8/
         WHEoHAOQZyrE3rdRSZTRajs4cR8BJTeK0dhK8qiXDp8SgEFlUX0IvbdddBz+/Xx36Z8K
         DrTnU6W/5RS8Lwyk2qmo8dKxWpu4RzkOajJGax/haOvKB67shfxKhE55dpd02NLGkTKZ
         hyzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779266540; x=1779871340;
        h=to:subject:message-id:date:from:reply-to:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1hS0PDSrIk78t1eXCsL5SyXcGby/9NID8KVnMHtzils=;
        b=EpPyVVYyS3w8Zi+TfDwgRqBIiVR7DZFUgrzaoJrNf+64BiVHzhUO/rnzv/5ZV5FpWy
         +uB/E8yDumueh4YGKskBWQxM0F8GyO4bGdcwoX77/UJ+FysomQLwRO5h26/Iki8w4F2T
         t+BfbW6nDEbQX601seH65B5tmq9Yx51NfQAcRLowLm5c83Vv5FPrzFdM9jPowgelU+MR
         jYb2QRJNlcVO6sS2R0HLefAgh4JpPI1VyWXaBwLntdgUyUhmqlnLMOTig0UUsJA4ZGYI
         aY/lL73Rd4ButsMU8vDThrROMhRX8CdVIvgvMo9SxRo5gw12npbhIxb+wKLr2hawlB64
         YTYQ==
X-Gm-Message-State: AOJu0Yyqow+9JbNhp5O9v4vBK2779QnXGk6XFUTUXblnB3T/cDOVHIj1
	73khBoCaWESUhbHGx9qNhSH+V1gCv8BUcg4PPWGR1si8eTkslX4N2Z6mh+AUEtbAs2UjWjI79at
	Ii/MiAwoQAlzC6FQX1dRWRL3PhETrPGmLboHH
X-Gm-Gg: Acq92OEtb3OylwIdQcg6YpIh3K3JTDP9sWvHpoVeUZxiAlgA3j5diliNMLwWlIXedJj
	O2Zho8ruWjkd/XXgkP3QaqgALS319zWhB/2Lf6yNlWivOuvwbn7hLA83OO4HKHKPBM1ildbuch/
	0aF+iKU7QgLweEQciWEBYGwbewDknQsaDTUart8jtbeGLCNW/T4W/d1LqtzROzza9yh2DiDihXm
	RojFr3SMtL3g33jtbbRUxvlMUs94JCjLl23hX3o6LH5meV9bV6KNdetbQGs1f2k7sl6wxpPJvaJ
	hY127mpW
X-Received: by 2002:a05:651c:144a:b0:394:8fc:8c44 with SMTP id
 38308e7fff4ca-39561861991mr68862021fa.0.1779266539527; Wed, 20 May 2026
 01:42:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Reply-To: sedat.dilek@gmail.com
From: Sedat Dilek <sedat.dilek@gmail.com>
Date: Wed, 20 May 2026 10:41:43 +0200
X-Gm-Features: AVHnY4KPPOdiSf3D9owJh82CawH7n6nLYG5RZwzmpSRfk9afuoR5KxuAhVsAfLs
Message-ID: <CA+icZUV3EJDQ1eo05YrMJsrc021G6T9YTd__DGKEKgpNa4Gz1Q@mail.gmail.com>
Subject: How to unsubscribe from linux-fsdevel mailing list?
To: linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi,

I tried ...

To: majordomo@vger.kernel.org
Subject: (Can be left blank)
Body text: unsubscribe linux-fsdevel

But did not get a confirmation.

Help is much appreciated.

Best thanks.

Best regards,
-Sedat-
