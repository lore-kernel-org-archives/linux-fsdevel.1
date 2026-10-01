Received: from mail-ej2-f20.google.com (mail-ej2-f20.google.com [74.125.228.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09BDE3FFACC
	for <linux-fsdevel@vger.kernel.org>; Thu,  1 Oct 2026 10:58:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.228.148
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790852340; cv=pass; b=BPX7qzz01k8TtOjhtolY/2VRzSO4CWFmyl6NXhJ3Ww5gnnp6QINN9RIUvB/bOVyIA2G/gN5mC6hZvp/MR1OetwXQddRiM9KAkmGNUh+4ecsFPM9KU/KqnLszkkl7KcBnmUPcNsOo/UQW/S8ePXIEy2vUklGVp2YayBjg/Ni07Gk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790852340; c=relaxed/simple;
	bh=KbGEgPnk7vZYR+vl7/TWwf7XdN4fpXM/jHOacnKAOBk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AKFpomoFQOwXEGfItAEyETI7KYmgdWysgWRQ52FyPeinHyCz3GmE8Iu0ptzwjhdDbxB/jcco3UjH2HIVNGMNZXD4q1lKN7rxw0TfcI+FxW0cPOEu0V17cggSGwJgku0HqRmZQTx265ZbJ7XSWvppebjiei0HfN1NTzmu1XeoF8Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hEcqxHOi; arc=pass smtp.client-ip=74.125.228.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hEcqxHOi"
Received: by mail-ej2-f20.google.com with SMTP id a640c23a62f3a-c293c683202so919442566b.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 01 Oct 2026 03:58:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790852337; cv=none;
        d=google.com; s=arc-20260327;
        b=O81suPO93n+fY4LaQrN8mvgSIzPVyEL3F3+RJTZ17/sbncKFDWgUCceg8QULV3F1sw
         TT4Y90xeBh9lZrUPU66vkkcxm2tLw5Yv4nDOnsSt+qBODBG6p9GDJ29lmiYdN66fkokB
         OLy73GQmxPtUrdjwInrQnF+s5SvyzdyU8qMsF3NFwY2L59pCaUJm3rdMOaEXQCyhOFBT
         f4cXfE8IcY6xRvY4HKSJh8VNZcSFUv1uiiHpgsOPh8RDNpOPETqFpptSON3BIyNjWb9v
         YtL5oIW7mWauY2Uvn+O0sYoNF+9JUz3VQbbUs+yDMm801oq7EyGLII+HJ6CzmmwdJM9/
         dVdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=KbGEgPnk7vZYR+vl7/TWwf7XdN4fpXM/jHOacnKAOBk=;
        fh=Fo0tt6m1iNgjOC4Z21VFSGZUA6Mn8am3HfBhFDYMqmQ=;
        b=dogUyTsak8qoiBLuKv+Ekx8N42j+P0OkwNC1NqmsnpFUhTNCQ7HY84HPwXQ1dy5TWP
         p/MNVZsZ1UaSm8cpCPoOTFqcmnY4l0xUPUEcWEq+vbLWW7Sf1OnCxZziYe39DhMaD7wq
         Zl9O8gC8YHKKNhxz0eaS+KZAUHNQqes2M5idphjHVhxl/LitU69J+70jwwth5LjsVzs4
         1XkCaiT09dxUagwdJKDMUYD1uEaIFIvv5xGxQD+/ueJY8bsjVwBoKAGWuPZuFvncpC9B
         OIx8ah/GOMJxht8nF5x1qvGEM3Uldrlz9FHy2Vylg3jbFo8r2GonEWfvVu9LDAhKcCXp
         WQeQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790852337; x=1791457137; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=KbGEgPnk7vZYR+vl7/TWwf7XdN4fpXM/jHOacnKAOBk=;
        b=hEcqxHOiuingEmH8/Sf/LuhYLAdSqW8jSge6P68ARYPY5iL3ADWBzchaRBG93lZvaj
         4fdOlibMDsAe9ZKN9OG18GGIN85g3fNTCE5WVdCBQx0pXZmHdXhddIkOokX/lgMoSEQI
         ul4DMM9QQJiVjGS5L9WnDMx2S78He83pFkxl3+4R/IvT611WmQyC7rZS6dzH4KpUea73
         Jzdp2o16kH3w1+n5+wN8yDAI4TwTuiCzCTtbk+gfC3YcFF7PuLHCmUlcMXb/yM57a2Er
         q1NUkkIHvCWB2Df2CQtU+emKmewyLjnCiqe3SRW87tKLvl4rhDxGcttJKne5naFWrnnn
         GLVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790852337; x=1791457137;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=KbGEgPnk7vZYR+vl7/TWwf7XdN4fpXM/jHOacnKAOBk=;
        b=V5hqdN0Xu538/Is6L4xZDVY/F3MrwIFmQJxJzB3y0jTQiwJTGaE0/2b6oT3KNN7ro1
         WFEdMUkVmL34Rr8cCVknUkXOouVTOBdro5l5Lna7/T+YUqy2g4QPXZEaIyIbM56C/cAx
         Jn9kTwBrgXLZfj0/rknEfm313cziKRhyVRlhJ6opGRNAecysnh8sB79g1uPe7AsOg6tz
         E/Y22u5HBSr93OiHDIL3VqqR/ljEP+Jks5iflIaHC1Ods3nFzX9nL8o/8aoqHMvY1H3q
         NRapO+G2B5QhNbU56gKkYYIHhG9gSSun+Yu5BnW6QQh0kpSq37IASHktn0zAbMgimshJ
         KH2w==
X-Forwarded-Encrypted: i=1; AKwUvByXwYYyVPufoUiyP7genKS/8WJYtLp0mgUMMd7TgTh5dl/UMYat2veyn/5SybL2lTsaoVsLAa3nFN1bwCLi@vger.kernel.org
X-Gm-Message-State: AFuF++krRxK2CRWwRSMu92lnRFxhVyzqtEqrmSWfSI8Pp2y+mcNyyxgG
	Qrd/qRHJSYX4SPb5yRuusLoHiJAytJ7g2eW0sVwlYF3SDeAoOmDZ8xEKWhbPdtUyxGkyg7OPbME
	Q0W8tkD03JIwwKDtscSNCQc/Y3UatraQ=
X-Gm-Gg: AYBFou171v0CzXwKWkMBBtOkgVpfsBmJXo8r8w3rjkcgA0zknfXBj8o7R8WqU4AdPHQ
	w0gf9T4fonPHxui+XE9Wm8bm7vWNtlbqaEL7YzQthbtfvEtgIVkW+CCwSTi6tUpc2ac37xjLsVY
	ie57/FIOPWtE0bbNqcJUCHvCOZgK3zxxU4zFdLrDZgoEbXvwPKVLoZ7mByUBi1RBGUscm6ZT8Dr
	fgfZmESMrr3NhEke91how3c25unl6bQDAuvjft7FRSNXrqD817MkKy7Vz6jZA9M9sMyKrpvtmyp
	Jb/hZzv9joecTNImEp3Mwok2fJO90O+RIjRpCRzPTQ8BKTgHMfTfGmMcD9poz9idZCrZw8RUgII
	G3jw/Ra6sDQ/wtwSaS1g9kbYL
X-Received: by 2002:a17:907:9688:b0:c29:5151:16b8 with SMTP id
 a640c23a62f3a-c2e23763c99mr352304566b.2.1790852337129; Thu, 01 Oct 2026
 03:58:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260918090010.1688-1-aditya.ansh182@gmail.com>
 <20260918090010.1688-2-aditya.ansh182@gmail.com> <CADUfDZorK-i+eOEpGkVFf_vJhqLUKfBX9n_rkiWtbcyoMHT8uw@mail.gmail.com>
In-Reply-To: <CADUfDZorK-i+eOEpGkVFf_vJhqLUKfBX9n_rkiWtbcyoMHT8uw@mail.gmail.com>
From: Aditya Prakash Srivastava <aditya.ansh182@gmail.com>
Date: Thu, 1 Oct 2026 16:28:41 +0530
X-Gm-Features: AclHuK-FOgD42JgsxASW5ZRNJ_Uwb8ZfRxtR396n_NYyi1ZD5u7-WI5DU3g3XwE
Message-ID: <CAK5ssPOAZ=PGDMjsihKCx87Gw+UBpc0J=NB+pOo8PbSBdzSpgw@mail.gmail.com>
Subject: Re: [PATCH v4 1/3] tools: sync io_uring.h UAPI header
To: Caleb Sander Mateos <csander@purestorage.com>
Cc: Jens Axboe <axboe@kernel.dk>, Christian Brauner <brauner@kernel.org>, 
	Gabriel Krisman Bertazi <krisman@suse.de>, Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
	io-uring@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 18, 2026 at 10:20=E2=80=AFPM Caleb Sander Mateos
<csander@purestorage.com> wrote:
>
> Can you drop the tab character and just use a space between the words?
>
> Best,
> Caleb
>
Thanks Caleb, will fix that to use a single space in the next revision.

Hi Jens, Gabriel,

If there are no other comments or concerns with the patch series, I
can send v5 with Caleb's formatting fix addressed. If there are further
changes needed, I can pick them up in v5 along with Caleb's space
suggestion.

Thanks,
Aditya
