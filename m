Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A87335C183
	for <linux-fsdevel@vger.kernel.org>; Wed, 22 Jul 2026 21:01:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784754120; cv=pass; b=cJ6beM/yEma7lDm1tOYEAh1YdgzWFXrXN6Qx4k0xBBp2ByZPwpREhsfvUmIMewiUBTEu7AyNdaf4qalHbNwlUF7YzLG8ptQNJ8TXPEKb9k5GEQhA1NdLmVynNAl0gGOiGxxavRpy+HfJnYc/OwrofguOEpUt8N1KEpI61NZv+T4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784754120; c=relaxed/simple;
	bh=e2ewHyAnmUOsw1e/tN+fqYIkcR6yWRk7QczuTMtWyS4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oWNuEHy1J95OoTQQ6VM73Sr16lW/xmatLeSzwVc1ULPQaU3CDJrdl94bGHMDyd7RVOs8s4/mxIvgaTCPZSqdPt/VcA8b3EDSHCyQpw8TUe4gQcOD1R/mJTl5v/XXjYTH6fVNZjNzlEUmNF+LRu2RXXp7Mi/DZOzLtntZv5mxSlk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NP/nXZGZ; arc=pass smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NP/nXZGZ"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4954afac04bso52325015e9.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 22 Jul 2026 14:01:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784754117; cv=none;
        d=google.com; s=arc-20260327;
        b=sraVw/PZrO0Wj2pnNkIOTgrlth+Jv3nyuJEL6bAAk0RE2OT6kLcAc7Yy2FgGu8TS0g
         0kv3xgEul0GjzERqjPCc5bhUUtl/Qo7GAXazO9sukln5N7iS5qaBHhoKoNlvPp4s7HUQ
         20FffIPPWj8CeP3dqQYYgFHqRAwbN3erfsfR/F5JhS8wfU3faecpLEGUnWYKZvEamx1X
         4AIQ2mCf6+ItqHnXHqZ3nht2wlptgZr94iexk0ZSpNaBmiRC6GBd4RrbTRam8MbCXfWY
         vxemJ+l/S1FXdMlmmcLGbDxUswevF8ww+RnCZtubEASW2zl7R/f9Oe1n1Q08SUh26+eo
         JTQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=e2ewHyAnmUOsw1e/tN+fqYIkcR6yWRk7QczuTMtWyS4=;
        fh=hEpITq6ULhlW+//ufVsOVT/QQ4gyVjN0/gOz1wqt4Ic=;
        b=RrMTT0YB4/G/w6HOTLveXzyYyXrPv4qFG+Bsd+bqJpa53b3KYJEs1LaD3bC7C0DCw2
         jCJplozbOE6IcHNhId8jrmOloFE31tkOitPhUQCIDy4VT4wgx/Y3fc7SCQelf9TIVlx4
         y7PCfZpiXcN+nO/oK7N5vMqYV/zuttI4VdVhPiMnFrKaWPd/JNTqmdmdjq2H5juBYFNd
         /USgjexhIi8jzi6TEqXAwje1tLbn7UCF+eNd++JJD+XSLw7B7gQ1JtlTl7hC1wbip7Kc
         YcoTevk9FAsdT1Im6UzLOQFfzSuoxgtWPIIWfZ4wp0YnA+lzeEzJ0CDKz6VPYgOZDMsM
         fGCg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784754117; x=1785358917; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=e2ewHyAnmUOsw1e/tN+fqYIkcR6yWRk7QczuTMtWyS4=;
        b=NP/nXZGZe6/PNwQFXkRX+7LBw95w4hc0FiI68g+ghXpgByhpNq/AyhODxBQTE/yOGv
         7OHVXF26DkgBOefTM2P8QAndTMIJKvy9dCOS+XSxgARN6kgawKJjFLZUCMySAO7NCdua
         3m0ax3CMMPE9T6EJ++gDPkesLKdg/7TD6ckFMikXlaMJ4Uc9Ng4g2fBwfZbHhbQAP3wc
         LmeJXC6r1Wo6w56SmQLBeD/jlSmrEikpP/C7WhjU0RNhh1YPXIeGtwfIJUweDboow246
         hnULxokRMb8HCk4kepfXbuwBTdS2OhXWMJgk+HsQxCcOkXBFK5LbbgzjrdwHFCH+8/Y9
         OPgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784754117; x=1785358917;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=e2ewHyAnmUOsw1e/tN+fqYIkcR6yWRk7QczuTMtWyS4=;
        b=Ol0+l/XjsYRjwS8vNUCjnumat5IXtbvTtX7PPCLMsCtjnumRFVpzUFsDl3gOIvZKZk
         LIRGANfTZmNK9ETsOnWU8dAVxPzl68SfawMqE7ZImEYhTNaOxeHzM28d2gVxnK+6jSIp
         VmIgcTQHvPkJj5zwuqzhwIUJzeFMcov8eUv1kN1nuIHNtbR3v6XSPfbohKTHfKFu2PWz
         5vWzYB7NqAhLEpTE9dHkhDv/G54ps4UfIXecg14RlY6ee89BVTZtmvrR/S9NWUMmNYf7
         S9Mwayf9uNquGnH9oJ4I0JJ//eaIU/c1xzlSDuxP34YLTTfinCQqtAPCRBAWT0q0E+nt
         /HzQ==
X-Forwarded-Encrypted: i=1; AHgh+RpGkiJ621ZWbPAzM/aBSxkJMgReCKaYU//loUi5Wo/RhJxUsY4oGZZO47abDzrB74o+bVZTKecRX6SjaeJd@vger.kernel.org
X-Gm-Message-State: AOJu0YzSSACb9kngX3MO9gWL4gRjg2y+5cynVhKA3uvhsJtTFcRUmKOz
	RrsMrURdbMwd0grBNzAOQKCbj16rDmnIqWPDBcMU9LHwsBq9O3DXQp2mW5eZxLu2bmUGyJ+meFV
	PpEQUL9Xd24WtijVNb8jLtkUGZ+AtVJE=
X-Gm-Gg: AR+sD108fvZ/H/fAHos5yL0QEa1RwukqNqjpa7+PndmY0pxs5dTbYExM4UTm2w1RKmw
	LTq0PSW2N5PUE8qTg4BXN0FvPyb2Bgso/bSjiw4aUomQMpuaVmDQulKcyY3/jtd6aNL2V4IHllp
	yfky7Fqli5aHGWrVRhAXzNXbbIUQtt7VIUN3a+/kZzkj6Ap7Nl/GOLY5QgFg9yavHTlQO3VAoab
	joHtzliNeY+3G7KiE7XPK0WAUz02KyDP70fpoQDPWpqkWj/DBPiWwdG0CtctO7x4do0ddCY1ebH
	lzOSULGMApA/ij2jlp44MvMXBrppu8iQ1parWlUBfft+auM2SHfBLy2S
X-Received: by 2002:a05:6000:27cf:b0:47f:8fb6:c32f with SMTP id
 ffacd0b85a97d-47f8fb6c4fdmr41413f8f.24.1784754117241; Wed, 22 Jul 2026
 14:01:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260722124931.3159664-1-hch@lst.de> <20260722124931.3159664-4-hch@lst.de>
In-Reply-To: <20260722124931.3159664-4-hch@lst.de>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Wed, 22 Jul 2026 14:01:45 -0700
X-Gm-Features: AUfX_myFnH_OaKIVvcOPcgbNKPlzrgaHUDbZ760JNGIOLPsUeq3W4FF1lWRG3bc
Message-ID: <CAJnrk1Yp_X_qKgBFoQ2JwC8DgECZ09x5xsnj83iAQ8cDeXN2dg@mail.gmail.com>
Subject: Re: [PATCH 3/3] iomap: use GFP_NOWAIT when application for
 iomap_dio_simple allocations
To: Christoph Hellwig <hch@lst.de>
Cc: changfengnan@bytedance.com, "Darrick J. Wong" <djwong@kernel.org>, 
	Christian Brauner <brauner@kernel.org>, "Theodore Ts'o" <tytso@mit.edu>, Carlos Maiolino <cem@kernel.org>, 
	linux-ext4@vger.kernel.org, linux-xfs@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 22, 2026 at 5:49=E2=80=AFAM Christoph Hellwig <hch@lst.de> wrot=
e:
>
> For non-blocking iocbs we should avoid blocking allocation where
> possible, so switch to a GFP_NOWAIT allocation here.
>
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Reviewed-by: Joanne Koong <joannelkoong@gmail.com>
