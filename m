Received: from mail-dl1-f46.google.com (mail-dl1-f46.google.com [74.125.82.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41808380FFE
	for <linux-fsdevel@vger.kernel.org>; Thu,  8 Oct 2026 05:06:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791435971; cv=pass; b=osknUYuCk75pmPLF4yi8q/k3//To8aNwLKMoThaAmSaCTvb0zt5p7+wezn5+rz+qXe3t3sVxhigKaoC2agxXhmrfh3sONTNK/JMtUheXgZCu4e3O2isyyFz8IgH3M8um0Ztcb6CzUS4Xhy9DVXrnKT3iYds5P981bx5z3ZEMDRc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791435971; c=relaxed/simple;
	bh=DhPFUP+norEZwv0KY7wpIyhM3OFW00KpZAcEkkSv3Ro=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dylr/Qciq/vUlqXJWv2thhsPnmhfFKqOKkmkshM2nRdzqzVSnQB/C1SkhPAPXtQ/KuJIlZ7Oarj/TIsw/tGgTcxxjrWv3EY7vwmEH1clqu2tXNGo/6iCacZdvfeYTNKWdhHF0k4/NXNVcEjFgK5agckZDGXGno0COAUdtVXNOxM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=j2fWoIcZ; arc=pass smtp.client-ip=74.125.82.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="j2fWoIcZ"
Received: by mail-dl1-f46.google.com with SMTP id a92af1059eb24-15dd124bbe7so3006072c88.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 07 Oct 2026 22:06:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791435969; cv=none;
        d=google.com; s=arc-20260327;
        b=nw+AIaFEr9MJf7lLrZeDZzNA7lMqOQ72KHFHs2CDvaTpm0zlXx+fCCLsRDHFmvK/8C
         hohjMRHF7E9dWIJtkTjw6H1HeGJxqrY8za7fUlK5trn11yQJ9nK53t7h3rx7iUyHh0SF
         UzijZWFHnEFzkzNAOWhoreI1jzT5xxIOkal2K1E6m70Mt9Khweye/5xgzf0xeRl4Icfx
         851A4jASrK2zgAfqIbRCBnJ+jzxV/hHVEqL6shDUzMnxS5ivQmgLz3wtjPjMvpYy+Ssv
         1TKIj+r8EvDKxSYPW9rlPPqpRUAv+P41RDVvxq3/u/1TZzieMGdrjdIQjD88B7+ikdqW
         KSnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=DhPFUP+norEZwv0KY7wpIyhM3OFW00KpZAcEkkSv3Ro=;
        fh=R6pVWMdpaDbWB1qu7BipnfkRdlPzHq6PAwjYHiDxD+Q=;
        b=jDYk5dxiH35oGwLPNpcnRvosbnwc8hoPAqOxR+OKYb3UCxSUw88yLN8n8to+zK2qA2
         +XLxtCafSksTm3BR19fwpNiV54uHedeuNdH+t8A3IfWE6B0XdT+BIb/uer40NE6q+x+j
         2w70oB+GthYK9QiO0rL/hLOCWVaWZU2yNabx16/Tiget+ViALkH8ftPwwE1r+yafVR+a
         /1Mw8dPuDWqQigMy/ma69YCPRmumY6LmcXY4l8E8FJo9Pia8cWyVCn8T+Hkb4tjRdvUg
         iDtKUsTW5FdKeFLw4hnJ/3VLq/O4Sm3uFDGzfyuBbr1nGiIbAaZQD2QPzXzhqBUzLSh9
         RZvA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1791435969; x=1792040769; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=DhPFUP+norEZwv0KY7wpIyhM3OFW00KpZAcEkkSv3Ro=;
        b=j2fWoIcZS/tDBrGxb0MRjhLY0LdvvVptsmSDXaXMwBeCzA5hDXnCAaYF/lm6r9+xuY
         DTHA0LJChgow5DQ9Lemfb1vFhXjc4Q5v+n7/pyXlbRJe4XPffgvtkfE+vX/ryzh/Gem+
         3h6YAgR4QSyr6aelvtGrmdcWAhCzrSCD8HsboXZ7A0bKSAC0UMOHxsVO12fLYUs5p2lm
         Lds9w1I3labq7J/wU29kPvvOfEk0PiINsOhAl4RpNAjf3FRBnZwsjD3wxLgHIKe/KI0v
         sP0lY3tZ+WZ3t+F18SrZ055ABY+NUHiXIhn4dsVsP5hf+fYYbje6CBbDBIxjfk0M+FIx
         Dt0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791435969; x=1792040769;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=DhPFUP+norEZwv0KY7wpIyhM3OFW00KpZAcEkkSv3Ro=;
        b=DX59MH6Y1GKZthorQRnSs+w1eqh3cRH5qonWwqWU4Fv7IzlpADw2LRO0Mvt/nmhYcd
         ga8axUISEmK6XiWtWkA9oqggIRrlnlificHfsEaxs79B+q0OL77cI49JWuaBHYQTQq3U
         Lu5WDZWI/pj85vy2tJDruC8xkqfPHkK0T4ILBSMtPquuxhoLzXJCXtgGxet2B5tDkyG/
         tYFwNLneRaHH0a0peDv8E/3u6JDMR4axfAfxSUX359JXu8+bt4kRhjPcL2w3sMb/mAH6
         6xhZtKj3uWJaEYYGz2Y/wk5n3qoMNBUi5IllmcJVX3KH8Vg/TIwUhvFPdnFWGA2cGofv
         Myvg==
X-Forwarded-Encrypted: i=1; AKwUvBykN23d/x8yLVckAFKyT37gtT2OT4DAEyJDAlQdhw1pE+az3mvoru2D3Qb8k/tLLyaovsT8Y7Ib/mxd9AKU@vger.kernel.org
X-Gm-Message-State: AFuF++k/xdSi/uhwh4pYcHEfN7NR+Jozrg0EfJmPKweeDXT/AagwczH8
	OPApvtuKU2JVZ5fr4dOStFufocHDmHLi0J8J/yXNchK0+BtDOFTsGtWCkN1wRJS4IkX/ZjohGiO
	xaqCzxC7/35EAIhiErf5GXMsTv1cerQ0EJdhX3Vwo
X-Gm-Gg: AYBFou0uPOLrsGknjEKU1KV3sIEqrkYV++xO9a17mQV3STWHmroOjSKho8z5C7Q2+VW
	XS4IfjYWVl+KUwtKDUJ48BMB5LPn0pcUPDNv9hRvVYwLnSTEFJcCrdsC/3PdBc/Q8nnzden+kca
	P7SFGwVKsreEVGY9wwME+X/gTa/i62aCKvxCobKu0+yP5nrbtB0xEhVkjL2pJNmhSwIqRTcXrNH
	MexsRm8UoeRvaAQiB3qoHMpp57Jy+KxhaoWS3Hb8kFI3PzXuhjjGFTkl6beugFqnLXTLwWmy9pU
	fucTckFYo61JU2dfGfT+RuXrWSbCr4B25talj2onbCA/GMM9gTVC36saHoHSZ+BMJPzq3Dx3LXd
	gyZ0ssMaBol4EXTUtKoAMa+WtQtGZ7twniSUSDgb1ZwDcz74Da2uzVGxs4fOjy/LPqgrkG8nnP5
	i44cawyg0qRGab9NTJoNKoqtBO
X-Received: by 2002:a05:7022:7e8d:b0:145:287:ce91 with SMTP id
 a92af1059eb24-162059dc702mr5384569c88.14.1791435968320; Wed, 07 Oct 2026
 22:06:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261005-work-unix-passpidfd-v4-0-350183b6e02a@amutable.com> <20261005-work-unix-passpidfd-v4-8-350183b6e02a@amutable.com>
In-Reply-To: <20261005-work-unix-passpidfd-v4-8-350183b6e02a@amutable.com>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Wed, 7 Oct 2026 22:05:56 -0700
X-Gm-Features: AclHuK-LcxOkOXzytf3Rr7yhTplfpto8Gsq6TYrBSnMDE5_TeVNBitGO6FALDu0
Message-ID: <CAAVpQUCGbFYwbJ9GjTTFr79Z5-NqQ8_V=_hE=iRRSGf4Vr5w3Q@mail.gmail.com>
Subject: Re: [PATCH v4 08/10] selftests/net: SO_PEERPIDFD_THREAD
To: Andrew Halaney <andrew@amutable.com>
Cc: Jakub Kicinski <kuba@kernel.org>, Oleg Nesterov <oleg@redhat.com>, 
	"David S. Miller" <davem@davemloft.net>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Willem de Bruijn <willemb@google.com>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org, 
	Alexander Mikhalitsyn <alexander@mihalicyn.com>, 
	"Christian Brauner (Amutable)" <brauner@kernel.org>, Eric Dumazet <edumazet@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 5, 2026 at 8:10=E2=80=AFAM Andrew Halaney <andrew@amutable.com>=
 wrote:
>
> From: Christian Brauner <brauner@kernel.org>
>
> Add tests for SO_PEERPIDFD_THREAD.
>
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
> Reviewed-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@futurfusion.io>
> Signed-off-by: Andrew Halaney <andrew@amutable.com>

Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>
