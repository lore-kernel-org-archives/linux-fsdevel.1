Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8C973EE1C4
	for <linux-fsdevel@vger.kernel.org>; Thu,  7 May 2026 16:38:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778171883; cv=none; b=rHbE7R6m3ug6bF9LPqYPkVQ49hEk61OLHR3QknxExBoifQyzL/8YxzTMQOSkMxgnCqPPdAc4l//NBvL4j/d2hIDlIUgr46CMs5ZQNVSCUQFE733B2PoVBNpNOBlM1IiqVi6/0HgaVrhL4p+tm+uKI1A0mUjHheIVo/bWaPiB+hM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778171883; c=relaxed/simple;
	bh=LLnjDxVt7odns/Dfdfy+Z378jFR66HKtSCFem+Ash44=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=sEfb6nZr5ZWKAnoF4a0AW3Iv1AIxcnO0b2y27pPSlvRIJFem72jJN3FgZDn8MkC+JQ7cnVOd+C+QwZRhcxSIEQ0i6ujeNmUO8AdjhfQqZGx4Sn1vlho0N5ZvZqw7AMzBAYCPJhoUR7x/i7Ro9L6Or+9wW9g8SrNaAgAwTrQmN4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HKmDA+oH; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HKmDA+oH"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4891f625344so12544485e9.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 07 May 2026 09:38:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778171880; x=1778776680; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LLnjDxVt7odns/Dfdfy+Z378jFR66HKtSCFem+Ash44=;
        b=HKmDA+oHtkQrKC6lZyX0FdQIvX9bSocx/5Kub5a1L5ud8i9vVG+DauH6h7FU2riQ3a
         3T4UDFk60vxd73Rafw6hMvynew7itB95Ds5n7N5ZRToOZOJImJx4bnqA/EFukKPASKYo
         mHIhLeahdGY5oL8GfvnI0B6FO/BlwcmTYVOwPdW29GgTiLUrib0a0bnzaYZkJDKfOoaA
         tVRwwrLXDPn9XqvKixUDMekexmHGFC437Z+R5rifsl/0QEYodpP99rSE2sUchiIm2sMT
         FPx9VidNZNaqj/Y+455ikvJoUJo4Lh3PGXj+g0u3SzIrVIf7q3MoJ3M4RrNtzgJWRp5k
         4POw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778171880; x=1778776680;
        h=mime-version:content-transfer-encoding:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=LLnjDxVt7odns/Dfdfy+Z378jFR66HKtSCFem+Ash44=;
        b=hDNoGfo08le0+n0mCVs5dkvW6Ojt+mvTHvFRB3UIaQgR/w8kdqLHkyGLrrU+Lg16GP
         /ElDzrQOn6QJDptRzEe79pWX+BymDwFEcj8mYfayff+Jc0OsuHAVevRBz01CTBjDTRkI
         lGNo1ETQqJyAmO/iV1m0jyN2WCBHgjphCx8vfzbS/u0usRSNGZZhvAmOjibv+76mHwrY
         OtQWkD6yEWXiXf59dSlcCputQgjYQOxorDDU1eMqiVut9/ts4GNcuVCZXY1w/ALkDB4s
         cwKdCOPywVD5tGtXfnEubblt/oAfcNe1Up2FDCmU0GWNwBal1NrSS3BHxIGO/FapTdgs
         2rkQ==
X-Forwarded-Encrypted: i=1; AFNElJ/sE2LJwHJuBT0lIz4LT/YthTRZYtiRiZMO+l2GAJKFbhSgp8wQWwkGJVitb52IjtKqjcQ/M4y1EnpQeUXQ@vger.kernel.org
X-Gm-Message-State: AOJu0YxcsJONxhpDYkJTQTiIw/tmiEV/h4/wqXFlIwjREWZQKCqSg9BW
	Unrk+tUgduStfcrng/TACrIo29O9Dg++bEHReFh/6H+Bm2TWUx+rU3BpRFSk
X-Gm-Gg: AeBDievPjS352H95f7qotRZw8QABc0GoRwTweL6fYFEVshmTBin6TxEazifx9vz9LL1
	SboaxJ0k1Np33T3k5HpKAFTGC8p2WlsGAagSOM06WzAAmK8NRzBKmh+NrUlDYwV3M3Wdye78rmn
	GbOYWFdGOJQhj0wjRvru/GTrzzdOzIAlao4IP7J6YVrAElQxkOB9f72YqOYF0T8h29NeaPY3m9q
	G0iGrQDNq1QCtABjZwr2AJYyM/Kwxi3L4ATDzrj0TP1YTxCO+6oyA+3Vb217k7vSLsiN8GRl6Ja
	eO0RE4Q4sJ4o227jjddF4p+AEbAye6oL4+VqPk91qaZqbpV3hBV5IkpyqVhFTG/evGvwZjObR+D
	LPbrmiRkt2gII01rgJ2clElZsNCUgZ3QBE1VxNJ5E+R1LMOhp5ZrVDq8+wPmQ/BBf6A==
X-Received: by 2002:a05:600c:3e86:b0:48a:5339:a46 with SMTP id 5b1f17b1804b1-48e5dffabcamr54513025e9.9.1778171879875;
        Thu, 07 May 2026 09:37:59 -0700 (PDT)
Received: from debian ([2001:41d0:303:db6b::])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48e538fad5fsm148424355e9.10.2026.05.07.09.37.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 May 2026 09:37:59 -0700 (PDT)
From: Tristan Madani <tristmd@gmail.com>
To: vdubeyko@redhat.com
Cc: slava@dubeyko.com, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject:
 Re: [PATCH v2 2/2] hfs/hfsplus: zero-initialize buffer in hfs_bnode_read
Date: Thu, 07 May 2026 16:37:58 -0000
Message-ID: <177817187847.3894093.14769331709936824605@gmail.com>
In-Reply-To: <00306449e9bb0703aedc71b01fea2b04e33b2725.camel@redhat.com>
References: <20260501110218.29906-1-tristmd@gmail.com>
 <20260505111300.3592757-1-tristmd@gmail.com>
 <20260505111300.3592757-3-tristmd@gmail.com>
 <00306449e9bb0703aedc71b01fea2b04e33b2725.camel@redhat.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2026-05-06 at 12:23 -0700, Viacheslav Dubeyko wrote:
> We are returning back to the same my question. What if the caller of
> hfs_bnode_read() provides the len =3D=3D 0 somehow but the buffer has not z=
ero size
> on the caller side? I assume that memset() will do nothing and the buffer s=
till
> be not initialized. Am I correct here?

You are correct that memset(buf, 0, 0) is a no-op. But if the caller
passes len =3D=3D 0, it is asking to read zero bytes -- it should not
expect the function to initialize anything beyond that.

The bug this fixes is different: callers pass a non-zero len (e.g.
hfs_bnode_read_u16 passes 2, hfs_bnode_read_u8 passes 1), but
check_and_correct_requested_length() internally reduces the effective
read to 0 due to a corrupted image. The memset runs with the original
caller-supplied len before any internal validation, so the buffer is
already zeroed by the time the early-return happens.

No current caller passes len =3D=3D 0 -- hfs_bnode_read_u16() always
passes 2, hfs_bnode_read_u8() always passes 1, and hfs_bnode_read_key()
passes a key_len that is validated against the btree key size.

Thanks,
Tristan
