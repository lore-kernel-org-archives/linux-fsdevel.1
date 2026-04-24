Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC7CC372EEC
	for <linux-fsdevel@vger.kernel.org>; Fri, 24 Apr 2026 13:20:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777036856; cv=pass; b=bIEcrh+78Q4l+/IKUznNhyM/rdkVTdsSvHkAYc4cmDyF129W1AQ5L2vYkfRQROeAfA+cDxF8dYJsS2dfC6VpehMbWp/4ngfrqW/yCsSHnanBsFN0Ig+snnBFEEmMuYl1eEcG1h2XsZEoWAK5yFiIC9ePYf38V3h/gRV3rkBgyKE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777036856; c=relaxed/simple;
	bh=ASS3cGIUH/I1kiBf/Dy1WJ4mFG1Z1t92cIyj895Uf5Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FwnvsuHsGMM8L/dbyMwk4QFqAOiTBqM7N1VQ4wDbJ626gzW/LAUnVZADyLi7Y3nvGgGCUh/VD5v+tefdDdpO3VtXhSHvfuwhEIWn1kld207toLZNvE36uF6G2FDEUp5fxeVblsqBHfNXuTgDPrKCAtJx9ZX7kSde0nXtrDR/2YM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G3G0GFTL; arc=pass smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G3G0GFTL"
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-b932fe2e1a7so273312866b.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 24 Apr 2026 06:20:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777036853; cv=none;
        d=google.com; s=arc-20240605;
        b=ffubL/oV9WVclTUxzN2vth9oC70Hsa10RNXRueiCm6XJxblTt+0cScEe86Y2Bth5KY
         AhrP/noqACq+Y4W15YnZ6TvnwgpIHf0sDmTUuI2PDkwBeMynXuAPoSi9i+eny+xeEdXg
         druDDNcJzwpalVTDT0o7UPytDd+7jCccP0YCaaLXf68vM/1ch+XmNkeK50DcNavo3QqU
         ijTSicb6VcdWNwDVpCyxRQQQZu1mQD4m3MCy+WRHzRbLcB8sxUvyatMAESUUP9gY7AbX
         DAO4rzboDnYdn5jtSpPhlPkKD00yxnGqnyyGiO0M4xJCXA8Ye7PjoB7tXgBJhLNmtsIS
         TgCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ASS3cGIUH/I1kiBf/Dy1WJ4mFG1Z1t92cIyj895Uf5Y=;
        fh=DR5CKgTdqAxbUSlyCttSCX4GcC1Zf/dB++OTsa/egi8=;
        b=RXo3mDL69Gr20vwAJg+Ak5t7MxXzy+8ebDbsC49vqcQXDDkFyh2gphOQBldCoudinC
         sTCKHUn7YnDwIluwIKZKuRwoHDF6C0NfC9F/p6CWn/xZrOm8QuHJw61RIH/+51u134S2
         lwkgM8wnCmbw7yfH3GQPipa7NT2LySMgJe6c+UfJcwNpXtZl/K2XYVK9TbJPz/yKuZzS
         QGgLmw/Q8ubfpx2Iz0woedjSjH5UB2jvfyGiqnY32uF+VVAZLyYWjG+HzDOAlntwr7aH
         qm7zHy+aSTmU9qU2PptunbQOrMI+mh/gECHbEf2WvQfD8uoBUyTS32f0CGX5opUSB8pv
         KreQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777036853; x=1777641653; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ASS3cGIUH/I1kiBf/Dy1WJ4mFG1Z1t92cIyj895Uf5Y=;
        b=G3G0GFTL8u6BieWBwXnTVyAyWJiob4JW74lnONgl+e4w4W4lKn/RmQsIK+x/VI4jf6
         NflDdA9V7x2/E2VOhTJCyxMY2IlDLxXYpn5tWoNRP4mCQgmI76SyDsvGSy2aIe4oGum9
         CyvKTJ8cfXbhRVNWtmQYkBX8SCACLg1Q6FzvCAFmHimbNIJPGNmFExiWQRhmRelE9p/d
         zvMFrunzBsepClEnkPIlDR0+FrxO+PcLHFhiIpLaC4blZZErZmfQyFQy0K/Wk1Zop/87
         Bkj52UvHHwffn+oHTSkNfRracpkSIuzoS80cM+VHPK47b3nW7MCCHWIJacyaVmgo3u9f
         6qCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777036853; x=1777641653;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ASS3cGIUH/I1kiBf/Dy1WJ4mFG1Z1t92cIyj895Uf5Y=;
        b=jAPvoDsayPEvbRKUtc+EvC9IFFqlgFTs1Gi8snRFnv15ZePzYx4IcUDGtDittG61SC
         4dgyXm58R5eYNGZjJMlwrFymqudadPA6MGhZJzCMRul/Gdk+8Os1yeE2yLri+Ug8TywX
         0TV5GChhb+0FifcmzWxpFHM38RoRXjlo/MMGlB+mghlrtC/Zqj44O+0Ejbd/LGR/6ida
         7XOkp6A4DICwY8QxOVDL/resywmSzH5+Jdv5wXrb+o+LbobJOdbFxho9HPDdy90QM/N8
         OILXVYfCrflCl8DiidIw0t4dvVgPISwlhLuaoP6Y7JWpLh/G043arFs2VM5rEWfb56Pz
         WQKw==
X-Gm-Message-State: AOJu0YzQSqBepCtrmL+iFzdRYlX3fPs9+Axpqqso4NG4WG0y6fKFdCZp
	fcA5yN9z5BzUuMMGbpYZ/yBXL0eOrdEFnHgDRj0HWOPLIGDSO3v15AF+l7voCLFrCvNghK+4jAj
	kmKxrnREtoffovu5inpWA2a8qtJJOeLlcZk6d
X-Gm-Gg: AeBDiesPzJ8W/LYALIfYv9NV4rnK2at9aVcA2KqyppdNe29XeWVCzk99F8N2tvriQfz
	MUFwxueALPa+fLogWWyD7tW2vLp4SJgFe6bk0Vl2Hg4vGgZ2OgarkfjmqzVeSKwcf/kmcwQdvnp
	hA0oOIkBmjmsdz8enhkR/+Cdfh3aDn/gbXW9lhQZjW8nBvDq4djuqPJ3c08EmF9LLauB9jH0dj5
	yNC76DEpwd+w+pK9ALbypFbccfEG6//OsAEgMlkeO5hV3LuZeRTBmep55yrg2iY+oG4ORBMCNSl
	lUE+yyawg6gyxp5e
X-Received: by 2002:a17:907:c1e:b0:bad:d21f:904d with SMTP id
 a640c23a62f3a-badd21f9640mr134660466b.31.1777036851676; Fri, 24 Apr 2026
 06:20:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CANT5p=oV8kcE6hXPoUVQAYGaiz+2OERoSRLAS6X+q9KJ_8w8YQ@mail.gmail.com>
 <438478a7-c965-4a2a-9c4a-84b5f77d6dbe@samba.org>
In-Reply-To: <438478a7-c965-4a2a-9c4a-84b5f77d6dbe@samba.org>
From: Shyam Prasad N <nspmangalore@gmail.com>
Date: Fri, 24 Apr 2026 18:50:40 +0530
X-Gm-Features: AQROBzAWgiHMPutXPKosmS70CLbZfFyKsRjxdv-KyVf-hd6DFXM_DKprRPT5BlM
Message-ID: <CANT5p=ortwT7ensa+kKoCa=wMnGETpqaQuBnhDWMSNu82KsqFg@mail.gmail.com>
Subject: Re: "Intent" of VFS lookups
To: Ralph Boehme <slow@samba.org>
Cc: linux-fsdevel <linux-fsdevel@vger.kernel.org>, CIFS <linux-cifs@vger.kernel.org>, 
	linux-nfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 23, 2026 at 11:13=E2=80=AFPM Ralph Boehme <slow@samba.org> wrot=
e:
>
> On 4/23/26 7:01 PM, Shyam Prasad N wrote:
> > Wanted to understand if this is a problem for other filesystems or if
> > it is specific to SMB protocol?
> > SMB2+ protocol mandate that open call specifies if the file being
> > opened is a directory or not (regular file).
> sure? From memory (though the logic has always kind of escaped me) if
> you neither specify FILE_DIRECTORY_FILE nor FILE_NON_DIRECTORY_FILE the
> server is supposed to open the object regardless of the type.

Hi Ralph,

That's interesting. The spec does not seem to define this. Perhaps purposel=
y?
Will try and prototype a change to verify.

--=20
Regards,
Shyam
