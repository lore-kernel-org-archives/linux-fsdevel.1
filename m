Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 959361B6D08
	for <linux-fsdevel@vger.kernel.org>; Sun, 26 Apr 2026 03:48:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777175324; cv=none; b=cnJ6O30hfHmWaAtjvLMkvXJRDUeG1sEOnUoq1OXdVXhrk96k9FgnpXPH7/tiDHcFcrU9Y5rtWjjfKpPIlAFhMU1jtpRLt1O4TQZZaDnazPjPwfjKI0qAHH4KTspAfSHOa9xcBh5IjkJcMN//PfpJX408228ocRRAh3tB11gaSI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777175324; c=relaxed/simple;
	bh=HHvz2ZaXK2QzcbGlnP6++xk7IMsKeIjuCIvVKEiF1pg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PLSFPqGSBV/h+VE3zSwtK0iAObJ2l+cjiLvalrcqTLcCq50RCPtb0vwJu8m8mMfUlbk3+Sb7aOua+YNET41xednBhJzqu80KDfZpMmSaKxpvp9DAjoSvAW93rkYvhu2nMsgXpCcLAFI+T0S7jL6tD5dnvIZ7Bi87trk+FVpVeX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OPKN2n1a; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OPKN2n1a"
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-35e4617925cso1458891a91.2
        for <linux-fsdevel@vger.kernel.org>; Sat, 25 Apr 2026 20:48:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777175323; x=1777780123; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yXMnx4YKj4/qFMA703J2yeE4ZGQGpkhF0QjHKR6Xpfk=;
        b=OPKN2n1a+c1y4tgJi/KujuFP0MKVLdDUeJrkkzrWrXfR8oprKtc/VI5oIS96/UHXSG
         CXknyGov+LW3JZCLbftPJiumjL/fQZc/zaCoRWGYPpa9jnYYHWTvogHfDaqD9fI/rD/Q
         EW07Y/WcEoHGxSmTr7d7tx46uYsEHMPq8ZuxjG1+G2XpCMYruwJtKLvClxSD4QFeM55w
         63L1FrvWId22sEBeyRfa8t7r5v81+bG6/snmiPnVWG61nWg22CzyeGLWPmvQcuXkeFgk
         6AHJCYc8sFKNp3P4giQ7u0PpiyMZdhjU6jtfcXbru16HpmMJd3IrQIKgIksMdvCoPYWa
         Npnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777175323; x=1777780123;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=yXMnx4YKj4/qFMA703J2yeE4ZGQGpkhF0QjHKR6Xpfk=;
        b=Mb+uiXLCeoKHCS/h9PDM3JxJpo5Dc3ILgONKMYN/R9tm/94T6ILUmbKQQTNwIC9nZ0
         hzLsp0Xfbj9noRvkWzHiDOkSShOcnzaHkmVuEoLR7NSiqptAu+eTsMf0iw9C9L8Mntm/
         NHN3bRFFTX+OQBNJFEehSV2lEYeO1RT1jKClywGGjBu8LsfM+BXwgbGzr2wv5I5kvQ/V
         8GZwiALA7IVeGsBZuVrShhgFjBvKjG0UnYSyYO4Fi4NLye+8tSeQZ7by6NyM1Le4CR0h
         wwP5dSd9K2PaBeklRIghFil/RjhsZ3pnKTldL+3+Rho3Z+8/3jXlBZlRFm+QqNT4jQk+
         ZRwQ==
X-Forwarded-Encrypted: i=1; AFNElJ+L7OH4vZiR65i9fc1abxMZmxiX2H4HlSfOZL67fWzXt8gv5NgCuBmUfTLVGK450/igqqPTbGzIhPot3+zb@vger.kernel.org
X-Gm-Message-State: AOJu0YyrLIIW4GMeYlEWP7sS9swhCALehIOvAQBthzAPbRg661MNsWJB
	BJsccud09yqtK0gw7KsTs4qwfnVfiixZql7Fwhsccu5OZqb2htKoW+SM
X-Gm-Gg: AeBDiev0P+y7S1QjwQQjb03wvrgjCuFbG4r/dAugecaJjKkcsJ/vad6N9F0PjFJD/Ot
	jxE2f/Pa/y65qrTYDSIsXROIHgTmgLAer/9g6ZtvOB/7ZTXav4HjJ0VaJSlaEfN8ORqlmzdK+yE
	CryeeE4SCEK01Kuf7Oo8nxMYk/MfDFnPLjcrAA6aB3/T41SMVmCPokGEbjL7BsWTHHzFGnY9yGf
	DgGd8NEaW62QgkTe4igiiE1LdjdghFg3nFVJq6607qW1dNm6ymq77Ejn8yv0/A2Z5cqWjwFlkkb
	KPjR99mWfLVteEXk3mdDYIVNf8Z+khL2+WEnKCFduGGA5ai/PetQJSq3CLuuur/asU+Cn2Rel+5
	SSdMMCToPH/4V63iy8qIR9al85qolfx18pRA+k6L5+QmLpbJITJGgLqVyaS2Ce+dMFI5gEPiNDz
	RJ2pA0MDOGhXMVaP7iUNdJ9DHohYB7/7KNTxM0Zg==
X-Received: by 2002:a05:6a00:90a5:b0:82c:dfeb:2aee with SMTP id d2e1a72fcca58-82f8c8f8ab5mr20151736b3a.5.1777175322958;
        Sat, 25 Apr 2026 20:48:42 -0700 (PDT)
Received: from ser8.. ([221.156.231.192])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82f8e9d2f9asm29537147b3a.19.2026.04.25.20.48.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Apr 2026 20:48:42 -0700 (PDT)
From: DaeMyung Kang <charsyam@gmail.com>
To: Namjae Jeon <linkinjeon@kernel.org>
Cc: Hyunchul Lee <hyc.lee@gmail.com>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	DaeMyung Kang <charsyam@gmail.com>
Subject: Re: [PATCH 1/2] ntfs: fix NULL dereference in ntfs_index_walk_down()
Date: Sun, 26 Apr 2026 12:47:49 +0900
Message-ID: <20260426034749.409043-1-charsyam@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260425184243.116396-2-charsyam@gmail.com>
References: <20260425184243.116396-1-charsyam@gmail.com> <20260425184243.116396-2-charsyam@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Sat, Apr 25, 2026, Namjae Jeon wrote:
> Is there any reason why you use IS_ERR_OR_NULL(), not IS_ERR() ?

No good reason -- that was over-defensive on my part. Inside the loop,
entry is only set to one of:

  - ie, the caller's argument (both call sites pass a pointer
    arithmetic result that cannot be NULL),
  - ntfs_ie_get_first(&ictx->ib->index), which is also pointer
    arithmetic on ictx->ib that we just checked non-NULL above,
  - ERR_PTR(-EIO) on ntfs_ib_read() failure.

So entry is never NULL inside the loop body. I'll switch to plain
IS_ERR() in v2.

Thanks,
DaeMyung
