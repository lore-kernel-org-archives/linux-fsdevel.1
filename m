Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53205364950
	for <linux-fsdevel@vger.kernel.org>; Mon,  7 Sep 2026 04:24:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788755067; cv=none; b=RNFWD5tTV0K9s6AQuA/c0prgeaYAM7yasRFGuSD737+rnVr/FXV87aKtEMizaartjU9nEUTNJUwrOCaAvpmJcPdS3rR8RTxO7MXkiqAAfOMm/T2feZ3f/mHJOy9jKQPN5Ten354QTmS7U6L5aR2YXK+NteOwH1A+WmHrLGjF0Us=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788755067; c=relaxed/simple;
	bh=lJDUxyPdhayx0ExZBf2syu+HfHSr7EA6KEMr71C44Y0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ADnbz4EuryldimLD+jHQR86W1etMYdL9H//IvBAVzZb4grwacEYxbcu180uKsl4ULXAtvp6b5ANgA/GPiP5I6V5XI3AmbNvQ0wLed2PmXvEcNqJ0jbK5eq9kKL9pzdXjL5dTVDYfrMU/65Ui5rkSFFKZhJNE7LjafIZQthpHzrs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YBd1QUZo; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YBd1QUZo"
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-cc1a4c62804so2374868a12.3
        for <linux-fsdevel@vger.kernel.org>; Sun, 06 Sep 2026 21:24:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788755065; x=1789359865; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=oJBeYuV5iB0P/zCTwardR507uSWbJkSOyEux2XLgUg0=;
        b=YBd1QUZojHmDvsTmSucJeJotD6pKeR/hzNShXP26uVItUyhAajHtO2jgDpOmXnD8OW
         ZesD8iZRzTpfRHAvLE53TKHY2JkvOj5WEbqSs3T70LvJf+l2G3brZcvy+PEZThn68LNG
         lSKOB9JtSmqnop7DdYjXCUte++xlch8F9GvgkblIvy0OMRJ9ZcmpsiQLZ4sAi4khirpn
         thAsLI5T0HmhCXcvEmOjRT9sBLYn5x07MRhNTKatx02tFsG0FAWMYvu30aqU6Lp2FLJP
         MRp+nkuf/vUatSSldJ/V69i20MmSuqsQA/fQRRG8E6P9x9MAR7guod4ZmN/EFXEnSJQY
         8HtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788755065; x=1789359865;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=oJBeYuV5iB0P/zCTwardR507uSWbJkSOyEux2XLgUg0=;
        b=DMGM1N0Z1QCFd8czNzraHHoXHmBxDpuXeVFP8rNo4RSK2v3SxrBMdYTIUJRm25g+xd
         P5nL7LIwXP4I5MP7XcCaJoBfqyq3Mry3MmZCgvHNtPRYYrPVTx7NpD4gUIU2xLU5rZ+Q
         7WNLBhc3JaED7jXC0YEr8DepBsdzdjvoTn4Du6Unoqhc1Rz0PNY6qFT+nSzhBOTi5zR5
         lmry5j5H0ebY8B6lcmLoxJPEP6TfH2KlJ1f95nJPcjihSRclwg2FdAsBTTMWSfvPqquP
         8AmnTLfKbPgnQ5uAXRstJZWGNK1548oZCLpzVFdcNgGncZLS7mH0X+c8X/SVZef9ytZF
         PRkA==
X-Forwarded-Encrypted: i=1; AKwUvBx+xnucDWuIKINMkvPzmCjTG3HuStFVPKMvq9s7p2+/SKj0i84ZYCMPr+trxInAFA8m2+ju6j2KmMuE+z2h@vger.kernel.org
X-Gm-Message-State: AFuF++krMn57JdZlDEE45vc6D2rGQHrypjoQNJP1z1IQFXiwnVFDRfaO
	XvSi0Hj7UYHz7aZVa6x/Eim+SeM5nWKuXPqcQutgOP4x7mqHyvq2Xq+W
X-Gm-Gg: AYBFou3TT6DWG0TA9ULX4+gha/WgGekVflGYjzAuKLIvLfJmmLCxOKT5VjfNmSDMyEL
	itt81aSj+VRhPoFGdD4GF/nHLoT++0Uif+431O7qVp2yXidg92b3pUwC75dsNBqd3nngJGSKRP9
	pmhZ/oRSYNgKEfmIJ/lHMYzQgtsDoLt6ktye2xQaNtF6CzNq2UDzD6fjJIdxze5lollCGWuC2Os
	5OvNEFlGqEj49pMiqGAfcp2Adrn1JBkHzAb7dT0fK2omlMCr/tY7l5QGqPmYDiPqJ4ElgL//fv2
	WHeQcuFfnppTlo7G/Curo5eP8eY8ENj8LVEF5swlPNiKWcCWWaLSj19hNnVyFKwJmLAnmxvTiuW
	UipZdwD5ty7ownkIWr7ciwII3ipeHQqYW32a6jrKFy+KKSw7YONelo/CC+YqBMMYTAv33CZt1MX
	bBekG/0nzxUnJQBXFutY8qqW3CHPATTldJ5tdmkHWWExIEt8f559QsJJSg+zeJlB3O7JUv+TwGm
	3PrG/OMW56D+A==
X-Received: by 2002:a05:6a20:c896:b0:3cc:917f:f302 with SMTP id adf61e73a8af0-3da39f6054emr30322461637.9.1788755065532;
        Sun, 06 Sep 2026 21:24:25 -0700 (PDT)
Received: from volcano9f6e-hostos.amd.com ([165.204.217.251])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3342af0bc08sm22629643eec.17.2026.09.06.21.24.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Sep 2026 21:24:25 -0700 (PDT)
From: Hemanth Selam <hemanth.selam@gmail.com>
To: Jan Kara <jack@suse.cz>
Cc: linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] isofs: fix repeated word 'in' in comment
Date: Mon,  7 Sep 2026 09:54:02 +0530
Message-ID: <20260907042402.12893-6-hemanth.selam@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20260904123914.583-1-hemanth.selam@gmail.com>
References: <20260904123914.583-1-hemanth.selam@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Please drop this patch, it is wrong.

  "the subsequent blocks are going to come in in short order"

"come in" is the verb and "in short order" is the adverbial that follows
it.  Both words belong there and the comment reads correctly as it is.

I matched the doubled word without reading the sentence.  Sorry for the
noise.
