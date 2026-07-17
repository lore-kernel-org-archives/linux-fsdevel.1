Received: from mail-yx1-f53.google.com (mail-yx1-f53.google.com [74.125.224.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F58A3FDBF8
	for <linux-fsdevel@vger.kernel.org>; Fri, 17 Jul 2026 13:53:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784296420; cv=pass; b=sqBzLx7JhnFbTHArVkxdAVIrwMYfmZQlcZoH8Qjj4mEbdEA8HFyC409KLKfAn+L0VtiqieF4c3IxUdTRH0OXivFTa4RVTWSdrATeazHGe7THMLh//iCIQX1nJbHWHfeamnV9KUlJOGERxkoTLCFWbX8fHn7UCygs8UdiyjYnxmI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784296420; c=relaxed/simple;
	bh=EHWB3LfSFAXFXyJUFl1N6jEYw6gLIGZ7IJWgkIphGvQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=shntnsO4tUxvCB3uomtwgoKzbQB/1xTMxn3hoSlVM9B53hQFwnfv8u2aKWIOM6FyJykZkiXe1kaL7T3Rn28NKUObMln9u3hCMMMvRU8QTDlTmv3Bz6XeBzWDeTrOf6dmflLkKqDy4fXyVubVO7dBhPlNeuUmFyMsB3DoUPdDL+8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Hq4SXsiG; arc=pass smtp.client-ip=74.125.224.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hq4SXsiG"
Received: by mail-yx1-f53.google.com with SMTP id 956f58d0204a3-6680ae2031fso3855450d50.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 17 Jul 2026 06:53:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784296416; cv=none;
        d=google.com; s=arc-20260327;
        b=RqTTQomsAE4UVQVht0P/xLsmiZ1qM5ByzV5/CZppo4QxnXxA8Rr6BA8+C2W4hpHmlq
         BJXm1jElcyvXNKn4krzYqiuSV+V7MrOUd5D4UPw0OyTduUFYQGZ5uxRF+AHdv6hENN+g
         WpuMeNqSeW3tPDPe3SO8F0Uf6BuOURkDlSmcrM8TfGsxtKoF1iKOmSPqoOFgtX9RuON6
         IwLuPoIkHFSguHkqMUVzYsjHFMoa1nE7iMMi/G+Tv+EYo7mRWceqg7kBr55WGZPilqbB
         Wt7tU+E3m9ewLXr8Y11/FiB5hxxsC9Nq5eil+HKb9VkirruEIyzsRjPdz7pkr2xbN+Y5
         wMNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Lz3BoFKZA6Vn4WjGF2gjgDhM537zMuXqkgmPSNZjHJE=;
        fh=pWODlK10pQ8gy/M7K3xqeVKGXLgVwhh/xv5Kmc6U0O4=;
        b=sjUe/UoTR+cgapaG46LdrqaozIjXtl+gUywBxNmsSwy3AztqVYowg+mtr/aUf+C5pO
         906X2agF2irHxTssN4Ln29RZwgJR7tTpq5DtSfK+uohsy8hCXfsNknOoiwd7ophjlO9d
         5HmRPI571iLcIIXVz2H0Z1ZU4wUQlXBxOXyk4UP9SkuCs9v40omrnUnic2tTJJS010+I
         XtX/q6dTsJOpbLJDZ3U1nsN8LsJN5ZczBcTJXJ++OI5iDfosDC6ZI688fya9xgDO0UrS
         wcrT0dBjPwOlBi3RWkzymABeFkSNJ+NL9e9Xna/w8XCKVabgIDcZIavHHfU5CwEU1t7W
         g8WA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784296415; x=1784901215; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Lz3BoFKZA6Vn4WjGF2gjgDhM537zMuXqkgmPSNZjHJE=;
        b=Hq4SXsiG8G+9Y+BEF49mCAP/5AY6RD2BiE/WBMsIeYkb9ABWX0Uq3l4FDCx1woaaOD
         4Z+otC9eli/SMPVZskZLSSKcLwyVr7RkovkKRpzpSayStYiigSo1Tpu1QuNunKkIgAyt
         9SbUuoFTa/lzw3PbphFo7LBRGOgd3+j5pR/tw5la92fiuzVMVC6CWloaNPTE6T9Nk1eV
         7e+Q6l8atWNE8yG0MrtrSIlN9ZAiT/jiujv4EJ3h98s3EJuygK5OimAJfpFnIav40wiU
         XuZlLB28ephriodGVY48+h0QVUqR9mGAudGxqP6oSmPIKGlwGwPBCfuXAL3KMl2ofSYv
         j6mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784296416; x=1784901216;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Lz3BoFKZA6Vn4WjGF2gjgDhM537zMuXqkgmPSNZjHJE=;
        b=SQV7xTMGnOLT0hMFVTjLRUy+WPfF16lmx1Qtq6XY/B9ugub74hilcaCYMlDIfQlTgK
         iv33H1Rr0MIO/1Mef2/8WtSMJPG3xCU/DLXuoCLZ7QEU6sFE0/kwWumNdsmgYgELKn3e
         EMiSDrqfdxmvWwR/P06azxgiKIjEToI6i973VpOiaws9hV5wt4UeB1nx8cMBPAHT30kU
         pKMFX0sVns1aSV+orOZ2vq3KaRAolVSVOxBilnSJZQ5MhVArhpXwRgGkVxgPpfsNWFRp
         h+CVTSEU7r+E6E2bnMOh0iRZmETkLWCBRSwnMzUaJwqglPOfzBfGGki0DHPNyb4k9gY6
         Np1w==
X-Forwarded-Encrypted: i=1; AHgh+Rrz8VyyhSJFMkfd0Cd2t9FJ6JtEylNr7dF9xz0V8emKUfFbyc9P+BJda8fMLNxPa44WHzTaUXWkfq6Ittgj@vger.kernel.org
X-Gm-Message-State: AOJu0YzuCtfafgGiXKKuoQQyNWQD1MA3gBA3EKv2TQqpmsbdgZ37J48M
	lly7ciL9Jbm6VtC3/8HnOTd7NsCwvNj3As5+y+6KglfwdLUgN8l8yrW+zGdx8+fIPvl3McIrGSK
	TlP495kJhJa6538dTWFINP86KQoDC5w4=
X-Gm-Gg: AfdE7clKXsVZW8XhKlThGQjbGVhu2o4u/frL9sL0C57BT2lPhXh+y6DQHygX2SXY4F3
	NpJr7ugZREqeq7+7PpBoP0zqJzh6Q3Hd5X3xJUUlyaBmvyqvClV3iyU6VCh4IRwKlJZ1pU9tx5Z
	h6dg7bUONIoUCN3liv3rmkHeHP3aDmukdZu+bkW75CXak7aCcGuaH7fds386c1WkNLLGA8hELTE
	XtANtCRR+pwp3UpjTdpCUib/uVySUVpUiysHCjgzNIP8DDA4AH95PhvR5nCSl6/G7DEVEhnXhWv
	AcxjlUlUfs7egBSGK6ELF/EoQidPfakW+rBK2Ld0so9AYKK59eg=
X-Received: by 2002:a05:690e:1909:b0:664:99fa:a16e with SMTP id
 956f58d0204a3-6683bbd3d66mr716823d50.39.1784296415640; Fri, 17 Jul 2026
 06:53:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260714125620.11119-1-kartikey406@gmail.com> <358eea840684313fe1d7d8f5dac239cf76121784.camel@dubeyko.com>
In-Reply-To: <358eea840684313fe1d7d8f5dac239cf76121784.camel@dubeyko.com>
From: Deepanshu Kartikey <kartikey406@gmail.com>
Date: Fri, 17 Jul 2026 19:23:20 +0530
X-Gm-Features: AUfX_mx_Fy1-b_795h9dU7YCvzCpCVGlxITeTYYUwPOCjOGEaeXmBPLSYU09NbU
Message-ID: <CADhLXY6Xdrx1YuY2g589mdN9PhDg_DJXk9vQqMHox8ypsgUWKw@mail.gmail.com>
Subject: Re: [PATCH v6] hfsplus: fix null-ptr-deref by creating hidden dir on
 remount rw
To: Viacheslav Dubeyko <slava@dubeyko.com>
Cc: glaubitz@physik.fu-berlin.de, frank.li@vivo.com, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzbot+c0ba772a362e70937dfb@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 15, 2026 at 3:03=E2=80=AFAM Viacheslav Dubeyko <slava@dubeyko.c=
om> wrote:
>
                    hfsplus_sync_fs(sb, 1);
>
> I think that true is better than 1 for hfsplus_sync_fs() call.
>
> So, we didn't call hfsplus_prepare_volume_header_for_commit() and
> hfsplus_sync_fs() in hfsplus_reconfigure() before. But, probably, it's
> right thing to do. But currently, we call it only for the case of !sbi-
> >hidden_dir. Should we do it for every RW mount?
>
> Thanks,
> Slava.
>

hfsplus_sync_fs() takes int wait, not bool, so we cannot use true.
I will keep 1 as in the original code.

I will send patch v7 with required changes

Thanks
