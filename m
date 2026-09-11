Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B89E73033E3
	for <linux-fsdevel@vger.kernel.org>; Fri, 11 Sep 2026 17:48:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789148936; cv=pass; b=uH4u7816//mS8PypWwoJ7Tr1PgCEpXbEcwMH8yu6odWDo3UVTISo193NEwxSPg0tvNMamg8Q3qU1Y2SEhDTAmEqHEw69myihek8xgm/tW+L5Sbcyhy/wq8OnYZ/U+7GL4N0CUR/Ln2FSDCcau8IS5dsBgAPnZYty2MszjvbGWzU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789148936; c=relaxed/simple;
	bh=bGLEgwaZgdYTaYM4USIx5xLZ8RRcvADu7JBWtlF3dK0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nDnBSz6Ef+czZE8SnCGPkIAcFGFa5PAF9C2bPmbeLhbhmE7mNNAsKPYMyl5A7+Y3as/8OLunbR+c3Jh9zk7XxogNoLbi2dIvH/B8y1FPTor1hq7oC3Fbx6Hy1qCBa7mWMrWxLqDZkeGDMur1cGIFBzyAHkFz/BZt9G+Bd3PosD8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=QBW/fSE9; arc=pass smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="QBW/fSE9"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2d6f9e2f681so14786445ad.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 11 Sep 2026 10:48:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789148934; cv=none;
        d=google.com; s=arc-20260327;
        b=Jrs5946M02VAxkgCPm/kIt6fYNW4IdUFbuDvh6feKIKL6RJzckI/aRwbCUhbuMHoId
         6cAU8r9o9SdQgaOZJ+4QBnlUr/q13DMgbaTTEmsVVr+LqF314tTHsXiNbzUQVAgVS/4P
         1Ms5qnAE7etfuLZ3weKACdBcaM1RDQtlMTf3nhNUTzqKaKvd9M62Xf9S/I71u999obpj
         1apTW+W2B2l6r+btqyVuG/RnVdDgLqmY3d03EzxTHOiIfnK8GolhC6EL6AvO1KS5/5Gr
         01aazYL5qX4oyN+7CV/X56b14zflODHzyBsZb+bRXhkHYpwB04LYRi8QdG7eqenW4Lzp
         DBQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=3CLJcEygTjkQvOeGhJ56KYzNxUmuL7Z1pfv45ziinrg=;
        fh=vVhRqumXqSf/vyUi4SSfVSs5eUnwLX8+1lUToI98cVY=;
        b=U7mbKr4KsvNR01B3FJ4zDYDJlJuHS9CIUeYgClAV14BiEo9OctDFFnrS89AJBKIjUE
         e7hxNMxotHheA8H7WdvXWXFWGih/ZVCccFyOczUj1RmWJhDIUFVksRtNJaQ10uvH9zF3
         ScP2Wnw0SgJ9lrQtF1JKHSnJ3pu1/Sz/W1A8TNxn+zd9wtbWyOQrAnOPiO5pP+ndpEk2
         yf8wCaJ2uuJgdEYmHMXVusSzQVPjOLKuhTIQedapc0phjdGR14YPyCN9Wx/1iUg1yTIQ
         Msmuv+uEj5voL5I/XIZ5au6LGYvWTIPoGwq0LZ7VYFrEe8QJPsDA5wPB+gDhmaOqSCZ5
         lopg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1789148934; x=1789753734; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=3CLJcEygTjkQvOeGhJ56KYzNxUmuL7Z1pfv45ziinrg=;
        b=QBW/fSE9UPJCNcmsbPMVPHczfxmDn4MBZ65qnztgGufLF0jjlNF+iALEkw0/wK0Rvb
         1u2K3ohYLGvsvWhz2UU1HqQy7NELOUNZbDUkdIg32sI6+jTTEUUSwhNG/mYvu3hrhP14
         a7xPrgGfqOQNDAQPN8Z11G8QPybcXSPSqg0YDFwWT96d4dTdT6ydQMy0X3yzuU7aGbJ9
         d6re+9vFg9g0slNv7a8YtXd943sLGbyWe4PH6Lvug759+hK3Fk2vlmZHUmfgTuPevWo1
         JKfulE5y1FyIBDZaSKyXQp/RTcqJNw3VlBCMDdfJFwK5OCziF2pf/M1TECM2o//leWZw
         zPyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789148934; x=1789753734;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=3CLJcEygTjkQvOeGhJ56KYzNxUmuL7Z1pfv45ziinrg=;
        b=GMUaJpyZaeQ5VG3GbC5UyZkpgfnGUEMy/iVUcRh3hzvbFHFO9Iwwng7xmkdj06A0fb
         DEJiSMuWDuleRbFwkqHZD4pDf6wVFnWqGYIRbzEAxAHxfyepgeqk2NTahN09YUhXHjKJ
         mcH1/i8QsSaDS5MjpL222ueIDD6DQAmRLS9e7cVq7MxafdUyTHl4tBAs5IaLiF1dw000
         98+oQUWxnJvyiu/2PZXzkYiphj5TkpPY9OkvKiC/SsUDo3Uyla7FldloW6yptZh71NIf
         wSR3xztSrHf6kBh9llPTjPhXbFvo8XCOpK4uBq3tsf7CVpb9q+iIAHgbX2jFpR8aUR7G
         j1wQ==
X-Forwarded-Encrypted: i=1; AKwUvBzv5ogQzqOJ0GSEb+4KOkHcKCbaf8/w87Glk+iDNSOxpJO3YNdc2pGBysLTsCvO4b5Lw4U4E6qbaUQJBhSC@vger.kernel.org
X-Gm-Message-State: AFuF++m9EKTanySer2ISPsQID/s1dOBleiaSTyc544uRJROR7UT6ihEi
	1YA1+tvek9kZEulfJbRgurZZwL46kTzrXoEa4SPxYW8ECkrWGltSoIFWQZ1F+CHx9hogkbJIdMf
	4KNAmws2SYoDsi8WKmzHnkhN+mnSvtCxjvKG2lc4x
X-Gm-Gg: AYBFou2zwgvxUbHKvt+qXEdwDgnIbcZQHAKeYzHzx2M2gFqyhUnen1QFSFP8ym+h40q
	VS/D6Sari0Q66uv4/RU5XZeDQmX0reo9G3sz3XeRMRyASDbIbLstd1EOHQh+coQQld9feV8L3un
	W90+kllMYrnty26tQzHbIcfbED+y0P4oU5Q9I13pYppPYfANZitEAKyYbiDQdoOFT+FcOnfGuMn
	Hs62ghvluWuCQPqQaiqmxC/ohhAdYSzZB021V7XMbfWQumw1q3Wsynaw5Fahiv3w5Ut+jwhSiN6
	EKUPl+1hk0ufGJ0KDKBJxBxyJ1v47NId2uLyBV+4xDV6gjupcPCoO36sM+ORWkGD/hEujfB5DoR
	rEQ/46WcTvJA=
X-Received: by 2002:a17:902:dad1:b0:2d5:e3ce:3988 with SMTP id
 d9443c01a7336-2dd2a33fb90mr92851875ad.11.1789148934087; Fri, 11 Sep 2026
 10:48:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260904-lsm-mount-idmaps-v3-0-920a1963675d@amutable.com>
 <20260904-lsm-mount-idmaps-v3-1-920a1963675d@amutable.com>
 <CAHC9VhS5q2=6p2bi5c7CZ3mutji1xiKR2eFKgJ9C+XZsYgky2g@mail.gmail.com> <CAPa8sAgVFXz4ZX-OR3YoRM3cOSqL613NnpWfgsbKiPjViOziBQ@mail.gmail.com>
In-Reply-To: <CAPa8sAgVFXz4ZX-OR3YoRM3cOSqL613NnpWfgsbKiPjViOziBQ@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Fri, 11 Sep 2026 13:48:42 -0400
X-Gm-Features: AcwNN1UU6zUyGDWy3WYAod5nfNhmzEn1TsvRMrlE4i5DL634iZyubVBEdQBn6lY
Message-ID: <CAHC9VhSD0Cdot=wy3mVyxCCD5uaCQ_bB5EE6omDFqyJoAMPG9Q@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] lsm: expose mount idmaps to inode hooks
To: Daan De Meyer <daan@amutable.com>
Cc: Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org, 
	linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 9, 2026 at 7:31=E2=80=AFAM Daan De Meyer <daan@amutable.com> wr=
ote:
>
> > As long as you are okay with me updating the patch with the change
> > above (and explicit on-list email would be good), I can swap in the
> > paragraphs when I merge the patch so you don't need to do another
> > respin.  However, if you would prefer to do a respin, that's fine too.
>
> I'd be grateful if you could swap in the paragraphs, thank you!

The paragraphs are swapped and merged into lsm/dev, you should see it
pushed up shortly.  If you notice anything wrong with the revised
commit description please let me know.

Thanks!

--=20
paul-moore.com
