Received: from mail-ed2-f12.google.com (mail-ed2-f12.google.com [74.125.228.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 814853812C7
	for <linux-fsdevel@vger.kernel.org>; Thu, 10 Sep 2026 15:29:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.228.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789054186; cv=pass; b=MNZY7v6Z+uwoUi6YZivR+jBAr1OhpVfKgtpnVqzTfTXXzTKk3Lmteio9aknvlOeFcbYJwXjo5ZAJipVzOqHDzJgDTIcrsM8qCbxOkiip7IytDE2qfIg4KxaFTnbS646oO24VLHxSTxLI/7rkphOaD5zaWtuVigbuOsJ/BsX7VT4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789054186; c=relaxed/simple;
	bh=9VQjJt6a+185GkYjPMQmDeyCxl5xt0e29jz5LgzWiBs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=swFtibtMEpRAxg9KrFzMo9ofaTiN70aqPcA6fjf9f1UYCp2RESt9tpOjbnt2igj4qIelMziKkMVmANgmK+XjaiXcbvCooCqlqXnwU69hDn/jxHseFMrqJVo+6MrRnDen+o/xsc/xW8ssORBq/6SxlI3j4rJBp89Gr8MgSOespT8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XfAUMa+/; arc=pass smtp.client-ip=74.125.228.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XfAUMa+/"
Received: by mail-ed2-f12.google.com with SMTP id 4fb4d7f45d1cf-6a6249b76a8so2679168a12.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 10 Sep 2026 08:29:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789054184; cv=none;
        d=google.com; s=arc-20260327;
        b=kzguhN/8wgxT8DkSUtuxJwPgMpvnVOeudjRIGzrmtVCWBEkg4GbHH6lX07lmH5zMZW
         1esSrJZvSp18AMowYNGDwGtQ0jPBUIzmZjzzhrxDTrsOooiy3MujK7V2/I1KFngs3u8q
         hb82hoajWOWurFTxyy1TlPJsMAJEqK+efCPeJJynCtH4wzVSrp0n2apB2aanvg9wfU/T
         b6hcUz3boilS5V2wB0L4JOmStGZFlxPLf42RzPPuv2YDYY3iMNYu8AcUUYRa4vzyIhdB
         8iGVpbPXZaXNwe5eJhW1lIrWffOpoFteJs8lj+TMDt71SyaZ4/53kYM7Q0VNwnWcoPA5
         xz8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=W02XYVTB0Nl5fojAG5hBMBTOksfDYePfH5xC6TePd8A=;
        fh=aMs20aBirGIkDmZ0luG0xLENUkP582I2nBsMzOpnNJA=;
        b=AStTZMkLCV9aq+V356k7plN+pbAQrahxQuq1dM8Ieli4pamM/2Q9OGX2LbacsQgrHG
         bTZ4oMpVR5xQE46UjcjRreU2UqLDOnPmQHPYbAVoN1bqtO2hjlncQ5oa5Jt0vvFzNKcQ
         DJ8JJgprjIuLNhbRn6EJABTLjYuTkY+1GQvh9g3wLnVqPpzZYRyQf+efgC1ZlMIPCh3D
         X1L4BiOz+GcqyEWl0jbzW9mIFCXKH/ZL1snBGU0pBGvACOC+b3/5ZUtXafGbHAJBB2Tf
         JAAJM0AN94wf1Hh9MKDSgDAR5KsIboc40OGd+QxRFXomWCWB6zwi8/HeCLAXR5TBpzUv
         zTAQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789054184; x=1789658984; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=W02XYVTB0Nl5fojAG5hBMBTOksfDYePfH5xC6TePd8A=;
        b=XfAUMa+/rCrdbj4MVC5oDbi5Y8Rd6oSLL4lnBmHDlG4hQ+jtZpb1mlQTQMdbxnrfgO
         UiEseSWcLe07KFc+jEI9EGdK/v6t1PHprB6DTN149LUMkef027wSCtYkpq/w66/S3FJv
         ZBVVlZKHwe0M5m/2SsceThXBP3uis6o5/o+EeD5OAJWGCeDxNiEjIeAR+w/RvzGjpKwg
         5P7ZnF59AGlBuFOpP/wzQWEM5LbSBfXo7mn7UyoeLkIFhmomcmJNc0a5TQTadhaLeh0L
         E/DV9Bbk2ru24FJ6ar7Oq2arSUYHwdTQdD6a8tYnidgCqf12p0FUnGiB7+OCT4t5UoiW
         /bZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789054184; x=1789658984;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=W02XYVTB0Nl5fojAG5hBMBTOksfDYePfH5xC6TePd8A=;
        b=IlnIx5G4mODCEvF5YitBi1uTMiuDevrOtCb8Lm3FRHE97c9OxIFoXbXSYRzucRd3Qy
         G7Cr7plcR1N6fzxNAANnwtTWtHIPU+lua+K7uP9H6gu5qdFRfIbPx0wPBniivt4dEFqE
         0nKov9hA/NSs6700pgb283uGi/N3ar2Lj2y2D+YWh1wnHBTwOXdY7DwMv8SgUwSkOnvJ
         /QWX2Np87Km5NKQ0NX2C7mvtAjz0nQmzczkPFlvQ8fDltgZRwS/m22vcmkhN0Z4b3cBv
         QsnulDtFYos12CgwYO9WpoOIsYmMAcA2iNDIuiXGEEo+hLzyfl7o1F5hjOyzAZZbd0Z9
         sUfg==
X-Forwarded-Encrypted: i=1; AKwUvBzXkXpgc6tjgP21mxW8Qm68k/BtbokWVaL01XDKKjy50Rc7LOC+k38fBJOIQR1TFxVIVnLt1FzyOyqpbcS5@vger.kernel.org
X-Gm-Message-State: AFuF++lvCIAjeojALYbqFj0giAY3JqufVZS4As5Zx6YB97St+OBfdNOA
	R+/xMHG1tvGve/7vC7HS2jNjlOlRnu/ndXFUqbJTlcf7y18tjUUJEu+Bp9SYSYG9BL/mPIuFx8X
	0sV9hyWYITzm4w+Ot8ul89W4DEM+/NcFAnr1nyf4=
X-Gm-Gg: AYBFou1QC7jtsMGKTo5vfLKakbXzZrBCBg+TCUBj4BbMpuKKyWRiPzVsMKMKhxWRSUY
	bu4i0ChFuyRwZNpYHfelv6cg86H5Wa3cGq5EQGRrswz5rKAXZzSLwKdlHxNJHgWDdK92fDGlSLF
	yx4KKXiJBJGzji+WjWJvPHdcsPrBcQWiood8zbhUPZnuMhuwfy1lpcwtoSJ5ffgG60EH/O95jJ2
	CJ1vG0Bq+tb4eMiL251/b4IBKHvpJtvbWqhBJiEGQYxkgKLpoWDcxE0Vg6LgGG5IxqQu5C6olX3
	ocHksc67ZefXWPRvx7mOtckqrcUUtVthQuTlCsWJwTufs04tt/POxxM=
X-Received: by 2002:a05:6402:3512:b0:6a8:451:32b4 with SMTP id
 4fb4d7f45d1cf-6a99ccf0837mr3371397a12.23.1789053870395; Thu, 10 Sep 2026
 08:24:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <9CC2EE8A-9F67-408A-87A1-62AF671B4BFB@linux.ibm.com> <20260910141524.12362-1-spasswolf@web.de>
In-Reply-To: <20260910141524.12362-1-spasswolf@web.de>
From: Chris S <coshi036@gmail.com>
Date: Thu, 10 Sep 2026 11:24:19 -0400
X-Gm-Features: AcwNN1XO9GRsWlKpqFSX7PpQbLAxVz7EBaLMtD1MZCmQjL9KwHLULMUzhoKDyzc
Message-ID: <CACd_6n2cPqmqs=Ao6yKGSzW8WxUPPsHaLJBOHGeMtKPkk6aR_Q@mail.gmail.com>
Subject: Re: [PATCH v2 03/21] jbd2: point the shadow buffer at the frozen data directly
To: Bert Karwatzki <spasswolf@web.de>
Cc: Joseph Qi <jiangqi903@gmail.com>, Jan Kara <jack@suse.cz>, Venkat <venkat88@linux.ibm.com>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Matthew Wilcox <willy@infradead.org>, 
	linux-fsdevel@vger.kernel.org, "Theodore Ts'o" <tytso@mit.edu>, 
	Andreas Dilger <adilger.kernel@dilger.ca>, Baokun Li <libaokun@linux.alibaba.com>, 
	Ojaswin Mujoo <ojaswin@linux.ibm.com>, Ritesh Harjani <ritesh.list@gmail.com>, 
	Zhang Yi <yi.zhang@huawei.com>, Zhang Yi <yi.zhang@huaweicloud.com>, 
	Bob Copeland <me@bobcopeland.com>, Namjae Jeon <linkinjeon@kernel.org>, 
	Sungjong Seo <sj1557.seo@samsung.com>, Yuezhang Mo <yuezhang.mo@sony.com>, 
	OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>, Mark Fasheh <mark@fasheh.com>, 
	Joel Becker <jlbec@evilplan.org>, Joseph Qi <joseph.qi@linux.alibaba.com>, 
	Andreas Gruenbacher <agruenba@redhat.com>, linux-ext4@vger.kernel.org, 
	ocfs2-devel@lists.linux.dev, gfs2@lists.linux.dev, 
	linux-kernel@vger.kernel.org, linux-next@vger.kernel.org, 
	Weidong Zhu <weizhu@fiu.edu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

You are right - I checked rather than taking my own word for it,
next-20260909 still has the unguarded dereference.

The fix is in, just not where linux-next takes its vfs branch from yet.
Christian folded the b_folio check into the commit that introduces the
folio-less buffer rather than carrying a separate patch, so on vfs.git's
vfs-7.4.bh branch 781bf9c7e307 ("buffer: allow a buffer_head to point at
memory outside the page cache") now reads

if (bh->b_folio && folio_test_dropbehind(bh->b_folio) &&
   op_is_write(opf))

That finished this morning.  linux-next merges vfs.all with tip is still
2026-09-02, so it carries the series without the fix - which is exactly
what you are hitting.  Should go away once vfs.all is regenerated.

Thanks,
Chao

On Thu, Sep 10, 2026 at 10:16=E2=80=AFAM Bert Karwatzki <spasswolf@web.de> =
wrote:
>
> Just a quick reminder, in linux next-20260909 this has not been
> fixed, yet.
>
> Bert Karwatzki
