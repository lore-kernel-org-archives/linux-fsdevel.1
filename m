Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C7D133BBCC
	for <linux-fsdevel@vger.kernel.org>; Tue, 28 Jul 2026 15:54:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785254078; cv=pass; b=HXaHJj+0hZQLHOCzsMR6viw2ANFIZNV/TXlYeJu+DSgZms1epoWRDhFe6Xm6WuJVx+m9/+AZvoDyz8gm9eEbPdnXkd8ODa4h1xlWJVdALBJ4C93m6ySVVW3VCzev2kLWvvkyz5vwcerPJ+sKX9IF39TBueoSa1wI7gu+YP9GKsI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785254078; c=relaxed/simple;
	bh=FBsfXxp655wnJEMHI9WpUa0JDeWDZ1N+76VJg9u87E8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=L6il2IcrZE69PE7vNu+lJjAsWvGrMjhCrBSFtUsR4WghhhXcHpUjOl2rTG6rrauadzqhfDclC/G/FZz2KfM5IhclrpNZctT3xH4YaMRdAZa/TZh3WL1vYZmqz7bc7oUnboi3MPqiU8wmnQYfABgEf5ddUh6Kl+uNmDg6F4nXk3Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DvmrBEZL; arc=pass smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DvmrBEZL"
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-471eeac43bfso17256f8f.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 28 Jul 2026 08:54:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785254075; cv=none;
        d=google.com; s=arc-20260327;
        b=LlED2e7k9Ukuhoc86iVKYyiuKH4zRDQvuWw0SdpDk9eYth2K10JCBECrLPovXg0ym3
         DPhrsGO0oRq1tZkXYURWFQwALYaIzODw0Ic3sab5sGRe7tcIw+rOJ7+gFsjaWy82EwD9
         D4CIdX7ST/e+uDsWAj2u3ku8p2I/7YETfnUD4BY+7L8VMbbNv28X6k7L8Eq6guQPhu4e
         AqJrSUmR9iBxu2fl3PEkO2bHyCe6GgtpF7stP01uORnkyFnEC6umjb+5Pyczzzu5FbMG
         WSS1EXDERdiiDy4Xg8Ra7HSE1NPAICXlweMA7J0qGaF41xb2LmJlr5OX4uV37ybaDjFN
         kO9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=FBsfXxp655wnJEMHI9WpUa0JDeWDZ1N+76VJg9u87E8=;
        fh=NTByM6YPLUmQjUaDUMExZECiZ+4EayAu8WRVbA5vt7o=;
        b=E2WmYgbP1lDndoxqzcGYzSSfpc7PFMPtOF/P8IyCjFt/9rPPtYQIPNH5u7zgOQxvhU
         99GmT59s4eGo/CovA8TYNDk7yzfTNjLTUhToh7kxpne2OuoN2gf7HvtKfv+pd+N65DM7
         w9S/4qU7iYJOv/8yvLDUyiVBDempncw6CGTBpzm7MS9LslBV4c3qRL6G/Sv/XpT9vrJi
         QN4t3y96kiNI73EOYwqVwcbxHz8sTKPFf6JCrHK+SobR9VarBn7StbzRtKU+dc1e66Mz
         Q7ILI6gwsco7ElBPQC0VtFZ7j6EjIPoERmXk8TQjcfX+BDmIcmnV5eXnXmsKQBclYqgp
         AqzA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785254075; x=1785858875; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=FBsfXxp655wnJEMHI9WpUa0JDeWDZ1N+76VJg9u87E8=;
        b=DvmrBEZL7nH+oUd0bdVfW5WbT//knhdRJQT5W/k0Kqv4JOFUI1vIlLKug1SvVn0Zsf
         GpuT7UTZBvAGBfy40EFzbw2avYwRT2c6lG8ncv68SNsK1v1estTbyrN3pHzMBrIUIs4Q
         1lzXv2q3jOCOCBOz7vH0u1VHbUM3EERr+kYR/daUEL1uMQXreL98BggJ7UyMtNdf3erP
         pwSaWAugMRhCVjX7nFYGYDJQOtiB5vVDlqtkU/4s7ROE2N8dKsCPpHfaOhCZG2DAo1TF
         34MX7D5xvnTtecdL7cgjYBvbBYyx6Ih8JfVn+pOVSQAZuUyagYuRyyJgQq7tMfXdFuKp
         S8jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785254075; x=1785858875;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=FBsfXxp655wnJEMHI9WpUa0JDeWDZ1N+76VJg9u87E8=;
        b=hQSxDjxggx+G6jdd0F1OHUVMGWvACVADSmRA4jmvZ24F15uuK4HbOY73NGqQXlVvrF
         sDkRQYvnwvTl3v2i/gG2mTy3DAlpEJhBheqJITASth+8ZkgtiISpKOgggPxfSNYsmgQD
         El/e82eTFKETkC0670ZONp751r539EZxKViKP6W2KyUiI3vQ4hOx+5Uvs5nBzogSk2RQ
         pIrGFuWunrPNCOfMgo9OgI852GnW71NivLZsvSy7HEq8JHcrHoHlYsVf1lOmiO/jbUHf
         n9289rskTVjUqLy9Uy6VcwLEUVfOP2x71XRKsclm8u9pfUsjcyyNTYYG+boKhRAna7Ol
         qSWA==
X-Forwarded-Encrypted: i=1; AHgh+RrVDujORAbZnUckqNlhpMrdoKM7UaHhjtMpyZPw/nhqPlCDCZELdOrr1CRSrWqg4KLHo9yH3eXQne9OwbCm@vger.kernel.org
X-Gm-Message-State: AOJu0YxWvi+7mfmFuXjwIsgYstRnFtbPS8QcrgFaoA4SdvG7vE92CiMg
	RhsZ5E2+hrtGUn9LWAgi2C8l8iB500FHVeBkC7IaMvJhGdSf14CMMkJvpvzjyH3sGOB31a631ku
	YGL6u9NvRgWxxMei7Rnjvew9gc6AT5Bg=
X-Gm-Gg: AR+sD12qKcnOSByOTEggZm1lT+P3oFtRhOpVIIPsN2vDlH96YM7Kz9X+3mF6ZGV64mz
	rzvtI4dFGEWYuCeF1ADjC9fxu4lyvStqr49UpN5+fee1JThgV+VtJ1djGiiOLfQa4oEx1xeZkkG
	svdT2XoN1q3O4Nu2YX5b5tkRSPH6xu+0TCnACZKon5jw9tuXNauc50Hlf3U4D3CTczhmaH9uG9P
	mKJkvAC+3ZDuZWieN+IvFRl5P98yuTz9yjK1AF1YPc/5ZXONTTE9E49kP16GZtpmNcnT2MKuE66
	Wnm4jqLKG4WsC8IqIw==
X-Received: by 2002:a05:6000:60f:b0:47f:90a5:be77 with SMTP id
 ffacd0b85a97d-47fb1ec88ebmr3876146f8f.6.1785254075316; Tue, 28 Jul 2026
 08:54:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260727143618.1582318-1-alex@ghiti.fr> <20260727143618.1582318-4-alex@ghiti.fr>
 <CAO9r8zNJ1cfCVgxtpqx4Db380bjZ+Z0P842eAxPXw6Mh4XBrww@mail.gmail.com>
 <CAEmasaXR5EmGCv3T5AzM_2908R-VjfMcObrACyVGokY2U=+i+Q@mail.gmail.com>
 <CAKEwX=P5G=Ckafy6fm9ws3njWP_Zm_AHRKOFERScB9Pkd_KvGw@mail.gmail.com> <CAO9r8zNsZUvMknjmH7MvkQ=09DnB9YvtYoA0ei5Hj_cESQAVPg@mail.gmail.com>
In-Reply-To: <CAO9r8zNsZUvMknjmH7MvkQ=09DnB9YvtYoA0ei5Hj_cESQAVPg@mail.gmail.com>
From: Nhat Pham <nphamcs@gmail.com>
Date: Tue, 28 Jul 2026 08:54:22 -0700
X-Gm-Features: AUfX_mwM9uU80mkdUZmobdZV83JB46gEM8E-6OObYnKo-qwfoaG6M9zE0eFhdcI
Message-ID: <CAKEwX=MPPEBBepeaJtvZUZBJL0KmP6zGevD9HqTiUCKO4Pt_Cw@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] mm: zswap: drop cold writeback folios via swap dropbehind
To: Yosry Ahmed <yosry@kernel.org>
Cc: Alexandre Ghiti <alexghiti@meta.com>, Alexandre Ghiti <alex@ghiti.fr>, 
	Johannes Weiner <hannes@cmpxchg.org>, Andrew Morton <akpm@linux-foundation.org>, 
	Chris Li <chrisl@kernel.org>, Kairui Song <kasong@tencent.com>, Kairui Song <ryncsn@gmail.com>, 
	Chengming Zhou <chengming.zhou@linux.dev>, "Matthew Wilcox (Oracle)" <willy@infradead.org>, Jan Kara <jack@suse.cz>, 
	Kemeng Shi <shikemeng@huaweicloud.com>, Baoquan He <baoquan.he@linux.dev>, 
	Barry Song <baohua@kernel.org>, Youngjun Park <youngjun.park@lge.com>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, 
	David Hildenbrand <david@kernel.org>, Lorenzo Stoakes <ljs@kernel.org>, Michal Hocko <mhocko@kernel.org>, 
	Axel Rasmussen <axelrasmussen@google.com>, Qi Zheng <qi.zheng@linux.dev>, 
	Shakeel Butt <shakeel.butt@linux.dev>, Wei Xu <weixugc@google.com>, 
	Yuanchu Xie <yuanchu@google.com>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 28, 2026 at 8:52=E2=80=AFAM Yosry Ahmed <yosry@kernel.org> wrot=
e:
>
> On Tue, Jul 28, 2026 at 8:48=E2=80=AFAM Nhat Pham <nphamcs@gmail.com> wro=
te:
> I don't think it's worth optimizing zswap + sync backend tbh.

Yeah that's what I'm thinking too, to be completely honest. But my
mental model for sync backend is zram, so I'm not sure if there are
other cases that are interesting that I'm not familiar with.

Normally I just use zswap on zram for correctness stress testing :)
That set up fishes out a surprising amount of bugs.
