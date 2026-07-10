Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 516E32DF138
	for <linux-fsdevel@vger.kernel.org>; Fri, 10 Jul 2026 14:05:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783692349; cv=none; b=ABlUPXhFLQA6ne5w4r12KhxdkastpVAvfuMtLJZgSR7cu6JWh/5akB3GU0u/AfLymXgcwwNKabfYeqhAGxXbRs2yJQtpLoOgkzx4EkV5K+/Y2e2ZRxjjOQTFrWqyjGIfcVaSQD3O21C1DV+G8BBBFdkKf1KH2digcqVdgdO5HAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783692349; c=relaxed/simple;
	bh=5a953HjukSSyYEvhSnpIbInmzV8jyiHUn0alyHLQwPU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Or060fbIQjTY27MHGPcHugN0m4uyvIIk1d9rOaAqpFfZYcpy3B+KYGDUMRVT4cP9XsDOFWjhm6TB0MOmnnGQC9hwwYhx5LTIx80MLE2deZUZv9F0uYyOSsckCjHvxI7B/J4TvoEKGtdqol6dQoPNF6IO2qGuTYTAN8qZOrHKr+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WgDIZWX1; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WgDIZWX1"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-493e8d4f4dcso8194345e9.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 10 Jul 2026 07:05:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783692346; x=1784297146; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=IVB60kv94HBipEp5RSQWAY1MglHGhZEQYaHj1G2FyFg=;
        b=WgDIZWX13x+zvAzx0ACkZKXbwPWjeyNTYZEqoWTmVzt5Vfivhi0GilDxszeb/wVESX
         fgWtx+VRaWyc+AVXgYSdiJtR8yIMmsmXPcrwAKxZNGi4TMDOoyaExGga+mX0ZdMiRhej
         5fqghi4epzr1I7o4XA8Rmso+F1QKHpRi0Wy2dkTPcwE38QkLv12zWgxSUrB4X3T4UonP
         Mm6r/+Q9jH05Oi6sg9QhS5auJPScLb0Lac3Q6/9EOAdoNuyG2VoObyDww1Qi6GpWAUzQ
         N8RQgRkKaQybqxlziIpGUZGNkZIGLRH+jt0wwvcWAJ7JtE1qTvriiacR7WYvhIT2Scuj
         pKeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783692346; x=1784297146;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=IVB60kv94HBipEp5RSQWAY1MglHGhZEQYaHj1G2FyFg=;
        b=RV95HNftInarvtYEwSnuIJkhCBuwdGom3D8rUd6oTkHTdRMabacir5Sh9za7ZVOTi5
         HAtibOFrE+b7/pBwtO+N8hzA4Jqx/xt6fCtQtvd8mcaZzN5ziwpMK4NUMkM7dUF8wecl
         xJEbuQSo6/IUhaIRW46DAFW9LnPQDigMQHQDOaQdmF7nnzAEIV/DEJ1+zfSEdBiWhDHK
         cl7aFSPu+kQUdMzN8C95jlqLckQXqYYIXhksZ6i9QuUIvx8APakFMo+RksAj9eDollsI
         GpQy6hdhE1xvuegEvx8H4xTqpT0t5lyD3gZmgEdixa7rAVgWUvNw6/cI0Y6Ym4xg0k+r
         X9wA==
X-Forwarded-Encrypted: i=1; AHgh+RpAxMnxCCFX3Ku9XtnyclkNOz+IdGaO1lIWv4r8K4pV0PF7/fQwhmc0j37Hm82EmkaUVhBoWcNq7ONqnrHF@vger.kernel.org
X-Gm-Message-State: AOJu0Ywu39yl7H1HykpCxOSo1UBfXwH7kYKprT4kfUEjCWLqqBXCtkR1
	fcMTZ6DHkKHb9cMMzh2s1OexvgJozB5D5idj199AKL0HMGYFv++6kNkl
X-Gm-Gg: AfdE7cmbocCDRfx/RpMYBXFGdmiizJq3akArTBcbUfEtq4aw9NOg5jqxRZUGqMkUiJa
	BM1F6TLzyqLm8k0PEx0z3VS8/BS+ZekxxWmXLP6gzFv9UdkPvHnqFw07n28P7NA00F3Idq+vf8f
	LDolAPDiHfCXTLkPRDCgLVDqNqxqaXYc0tAMBgqwRIzXh7r442q4YVWIGhUxSTLVmsq0MlX/t7o
	+axt7SUS4a9uPfpbE+xHBiZr8S0hmnxSSUGc4DqOOnMvgUYl1AJuaA8ifNKXIeCIYM9clXCD++v
	1ouIz99Y/piyFLuq7PrzioySDLyG2aSNbgyg4DcqMTROGFRQtn9Sn34yTD9dmKMEIhMY0mFn0D1
	IEF7qpHIEK00dpCUltXpwb4pXTTy5PilFdLVKE8PPd4X/xu1IPGSdVwEeljYGEHaL5i/2OCTtvH
	gRW2MbIxo/5d3drV36y+5YWq11ftZiCLxYjufkNtSgRmu7N6rp+N1wkJ8zhdpb
X-Received: by 2002:a05:600c:1f8e:b0:492:5e22:ef18 with SMTP id 5b1f17b1804b1-493e6861bc8mr105289865e9.9.1783692342549;
        Fri, 10 Jul 2026 07:05:42 -0700 (PDT)
Received: from f (cst-prg-85-255.cust.vodafone.cz. [46.135.85.255])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-493f4f09f89sm63478545e9.10.2026.07.10.07.05.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jul 2026 07:05:41 -0700 (PDT)
Date: Fri, 10 Jul 2026 16:05:33 +0200
From: Mateusz Guzik <mjguzik@gmail.com>
To: Can Peng <pengcan@kylinos.cn>
Cc: viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fs: stat: Mark accesses in generic_fillattr
Message-ID: <yeigo3ck7x6zzwwcm6msvenmy3clsodejvmv2g45oy7bixyybz@ji66r6db2ou3>
References: <20260710071444.301350-1-pengcan@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260710071444.301350-1-pengcan@kylinos.cn>

On Fri, Jul 10, 2026 at 03:14:43PM +0800, Can Peng wrote:
> KCSAN reports a data race between generic_fillattr() reading
> inode->i_nlink while filling st_nlink and inc_nlink() updating
> the link count during ramfs_mkdir().
> 
> getattr does not take the inode's i_rwsem, so st_nlink
> is a snapshot and may observe either the old or new link count
> when it races with directory updates. This is expected and
> does not require serializing the stat path with link count updates.
> 

The link count is merely one example, several other fields are also
susceptible (notably i_mode and uid/gid). So I don't believe the patch
as proposed makes sense.

Taking the lock around getattr is out of the question, so data races are
unavoidable.

I would argue correctness requires a sequence counter around this, but
afair the vfs folk are opposed to the idea.

So if one wants to do anything here, all relevant fields need to be
annotated. But I don't know if this is worth the effort.
