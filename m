Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9836F43F4C2
	for <linux-fsdevel@vger.kernel.org>; Fri, 16 Oct 2026 08:58:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792141122; cv=pass; b=IGzPYSJ4a43LdS/QMFXCVtmD+DZZ80o5elhR7UED+hRMpBY/RE3+EuBfa7QhbeaZbpJq8mW0EAdmTG/4Ig57p0VIqMmDBFyh/5D75E/WNEl69x18ia+g2XGtNiUu+1KX4FH4CZ+BJ2i04Fya7nO8sAtqaxXXlE4usOjayOZSQSo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792141122; c=relaxed/simple;
	bh=sTfPJ6PqC8c32ihJFSptJ3qTYD/mP7sZzo5Ard4uuBA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=R3DW27CtwIJxO2NzYaOO6DhuODDbCm9vAdFPm8fpzgVb7A9qqGgfMIcZmeARu2kAqdt79X8r+Gd5QUIb7mB9DhrvAs3FFD7vOTJ169sIz32GsYPf7z5f4TIy2gFB94kG8ndL8wk7NiU6MHTbobRwCSPR4PmWndSTvElpjrt71dg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=h6ysyMi0; arc=pass smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="h6ysyMi0"
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-535f9de49fcso15251091cf.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 16 Oct 2026 01:58:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792141119; cv=none;
        d=google.com; s=arc-20260327;
        b=OZlqJuXWNa925i/XPYL3EdTbxcGjUyAqkT4z47yGxFR/SHCle33GLzz4XL4ROXOwlq
         cfXsGw9L0mRnfLXW9MNjYZzJWU42PngFdlGiot8zict7ZHxw7PwziA5EasdayXjoNp8r
         ahV27thuA86ywdt8u/UcLv9yn52NvouBnMbtWm8ZyfVV2QFAKI3GPgIXVpdGYwNt/YEt
         +mSD88P2jXyI9rKNQ87ZtY3yKTH6SVbeVVbpla2fsOEVJSEFCmvdUWdc74MImhXNH0dR
         baGDkbqTRsrZRGGb6m0rLHoTYCgmhCgNsz28QTg6+SdKUY72ophwkzR9dMARtB+pPS4k
         pxzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=sTfPJ6PqC8c32ihJFSptJ3qTYD/mP7sZzo5Ard4uuBA=;
        fh=UKOxxnAE6WzpR29IP3cL3Gi2EqdKW5zwhxPVHkXdb8g=;
        b=fSQyxpk1ON8di48lNKsZ2b7bhAOzkBY+2fAkMKUSXWY/MYF44DhowLxLJM8a/Er0r/
         jIQkiiR9bDwLwaraGZImztW2guzGX2QJe+qKbp+D4vSzAUocEeSKyd49ioO8mMy55nCE
         Mut2Qt0ox1wBxaE3Z3v3CroRhRJAimgCEGWVvb3P/z1aup0Y7dsnjXF7gZSGJ2vxLSQ8
         dgPjuEA4TtYyQLJEKLDxIP+mtPV8Gp/ktjyefeuin51V/0djPBK54/lfGwwSmN+6geZJ
         yNNDTZth2Hn2R8S0CrFKkn23QE8l8twmPRFEv5ddTI6zLv/+61yggCAER57WG11ZeuvW
         znBQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1792141119; x=1792745919; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=sTfPJ6PqC8c32ihJFSptJ3qTYD/mP7sZzo5Ard4uuBA=;
        b=h6ysyMi0mncT1RBpL0m8Lkvt6UWlkki83vArzdTg52KKF30H5YXCDYY5qxR+xeQh9O
         EhAMmlGx4hJdEnQQIEAj/wqS/EBcd8mdhqXp4iI9Fv6vkOQ9rcn1kV3272OTaVpYh0VC
         tdO80anV68OrDgv/taqJaiNKZUZ9Z1t2TLEb8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792141119; x=1792745919;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=sTfPJ6PqC8c32ihJFSptJ3qTYD/mP7sZzo5Ard4uuBA=;
        b=YGEQjUJwVp3GV9/DedEI5ZdIq7GTA/BxTk6Jc++fa1j/Ysfvv0+xkf7P0Ps19LlCLf
         Jry2re1K0FyX+cvPQuiAlzI2VuMcrPAofmlxfIOzLzeHY10kSkdCcla6moWxs1PfdZor
         CKD38M2ubet4bUtfnMAv6JjfJNmSrXkQru9J9QP43a4Mr5/oWULPLsr1eWBRHw3VurPF
         CrkmLdomXOFW7Blg4WG/LhN6kqb3JanBuETWqncINa5bbAsyYQEqLVu7wAGXZowkGaDi
         wDTc1Gel8PvC1JS8ju+aEj3zvl8N6roQLKMEsXYrioSU7PfB+JZxXAndj72o2/rLpkCK
         oWsg==
X-Forwarded-Encrypted: i=1; AKwUvByRztcQyg/uIcMyWToCz4BziF/o8GaPbNsHOhBafkDZ7HYM779h8I7IWtVKWvmbKXNChSGFIBzuFkHEgM34@vger.kernel.org
X-Gm-Message-State: AFq9FYKi65hHNVr8JQIeqEc3I5OrpAj3UztiOvjKAXsqkQkzPpRakM6g
	8bKQ8uCp51U1NCFyBtjvabNWdYSAFQFoKLvLOwbkIfyX7wSp+xJUzTNb975nGRxiST8iEfCHIoz
	9c1+dZLRwSHhn92u32GImL3O12j+VAoG6iKWiUl6V07y5jv3G5heK
X-Gm-Gg: AYBFou1vieOAkg/fi3PPQKj0617Ln39Xqb+13ZdgsYqdL0B4gfdKn5eFy5gQCjDiCXA
	j0QuXAMtVk/jU9Lg7bYjiuxbXfz70QFUZW9+reL30vN0/b2OakoDwx+JyRpFxaI2n3dcZ/yCAt4
	Ae4qt/1w8sDtVk7iFXflWr6mLwHzu1TIYGTu3v8YIh9H36vhynlwtODdL4dur9YrxrbofcsGI3I
	4czftt7G+DzfN5beg4f4xruHYUbIU/VlBM+onVYmk1EgT8P/f1TmpFfzbaOvklIRKhFX/NqFEtF
	hwMyjs62fWS6VssaBBnweRGPDCVMlSdhXuSgLZoYhT5EQTsStoxV1jr7auw70chrpR0PX6WJEkK
	v2Yf2dJE=
X-Received: by 2002:a05:622a:148d:b0:533:3af3:43b9 with SMTP id
 d75a77b69052e-5359fb3d14amr366334251cf.44.1792141119518; Fri, 16 Oct 2026
 01:58:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260910184424.156341-1-shayba@google.com> <20261014192014.3373048-1-shayba@google.com>
In-Reply-To: <20261014192014.3373048-1-shayba@google.com>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Fri, 16 Oct 2026 10:58:28 +0200
X-Gm-Features: AclHuK8gvmL5wAjcEDGO2fjptGYL8jYpJoRVGU7iFqj19SwZtNo9v9Zwvm6lwLk
Message-ID: <CAJfpegu5agxOB7_9zW2u=0AfbLuZvp1o9OaW-A7YLvb==voamQ@mail.gmail.com>
Subject: Re: [PATCH v3] fuse: Forward vfs_fadvise to backing_file in
 passthrough mode
To: Shai Barack <shayba@google.com>
Cc: Amir Goldstein <amir73il@gmail.com>, Bernd Schubert <bschubert@ddn.com>, 
	"T . J . Mercier" <tjmercier@google.com>, Sandeep Dhavale <dhavale@google.com>, 
	Akilesh Kailash <akailash@google.com>, Suren Baghdasaryan <surenb@google.com>, fuse-devel@lists.linux.dev, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 14 Oct 2026 at 21:20, Shai Barack <shayba@google.com> wrote:

> Architecturally, Linux VFS supports filesystem-specific fadvise
> delegation via the .fadvise hook in struct file_operations. Implement
> fuse_file_fadvise() in fs/fuse/file.c and register it in
> fuse_file_operations. When passthrough is active on a fuse_file,
> fuse_file_fadvise() forwards the vfs_fadvise() call to the lower
> backing_file under the opened credentials, allowing POSIX_FADV_DONTNEED
> to cleanly invalidate the physical backing filesystem pagecache.

Applied, thanks.

Miklos
