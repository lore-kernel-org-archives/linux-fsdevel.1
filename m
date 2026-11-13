Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.225.139
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794573425;
	b=yiX6akOr5qIvktTGlYV9amgyE+3HcjPsHyR1M+U6k11aLP74+rtg/Xu5/+dryx1ZrtVD
	 21QndSBotIhcsOw1gD7GbSt1QRq1WGdIyS3l/wDpz4MXwTvCjcv7Q3mNTEk8QOoq+xBkp
	 eDkvIwRhBrpaftPwBeenA65nH23chbZk60m4rwUr183FUng9BR9ak3DT0Exnl0bvt1kEB
	 WCJTe/b5SlHLg4bIFPUG2HrfmlOnSLLfrUPbfvNg8MFp0Zl2hK05L2yYgFx/iNxPREe48
	 NWc6pmsAzw1qEY7/sYHUNpPxnSBSg/dYGEg9dzX3Oet0HKbTS4cfm/Ehl+Ex9/nhhZA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794573425;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:Content-Transfer-Encoding:User-Agent:MIME-Version;
	bh=87/Ge5NhXdmtGpcXCLUvnqWpWEAxiW5M6eWOW+m4zUs=;
	b=DBRrIpDtxElPgD3le3fGUxcV+7sxCoxa+zYXLOy9EGYdcNHGCKBi1aSq3V8kzGIYGwGB
	 Q4huTcKUSTT4PoLQfRlUSTClzq39IOed5nWYgIb/Jf1xc8zUUR7grXGVdZbywgOPyqGI5
	 p5GywTlo1xnyRFjXyBkBcNSlxb5N8b2B+RBig7ZCIf0FsRiu07H0HC1ATu9TPYFsDYaXB
	 OxKdwktkMru636mqAAiZrHEmW8BMD1+okd6zEx7yIqVpFzCIyyTS6eMgxEmkvNis96mZs
	 a0vvK1ahstdllaZCuI4sPd5Vip59GGMGCtpgdUdUUIR+ch9XiRfYHblNxsOfc3W0QyQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=amutable.com;
	spf=pass smtp.mailfrom=amutable.com;
	dkim=pass header.d=amutable-com.20260707.gappssmtp.com header.i=@amutable-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=n2XPHptJ;
	arc=none smtp.remote-ip=74.125.225.139
Received: from mail-wm2-f11.google.com (mail-wm2-f11.google.com [74.125.225.139])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8F09606A327
	for <linux-fsdevel@vger.kernel.org>; Fri, 13 Nov 2026 12:37:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D8F09606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amutable.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amutable.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amutable-com.20260707.gappssmtp.com header.i=@amutable-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=n2XPHptJ
Received: by mail-wm2-f11.google.com with SMTP id 5b1f17b1804b1-4a5f76661b5so3542125e9.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 13 Nov 2026 04:37:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amutable-com.20260707.gappssmtp.com; s=20260707; t=1794573423; x=1795178223; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=87/Ge5NhXdmtGpcXCLUvnqWpWEAxiW5M6eWOW+m4zUs=;
        b=n2XPHptJWAiGnWBjuWK6g5NkFljgiKFcabC8Vn0J/U7Rs5oCxIs8ae//bm8icbKFtW
         GhaGag1Xoi7ZyXwdHESo4gzqQGVIFHJ4SWyDVffZrMrzihrR6J8Y41NroO1pUm4S3UEM
         GevRMV87lpSFNCzDE68IInZGbL5X+gYDk7IApotAPKeUo9xOfBbHGBSC5mcggp0KJBcK
         Nc+e1mR1SmgmgC0Frha4Bk72pKDTzd14yUseYASwtvG8qZfbG+gNn4GmoQhA8ODET64L
         X6SskqZIriPJvj35d5mhI8G8hobVKdLKjnxeG6bMHAYcCPTjUD9dRkaaJK3nWVTXV/IA
         bDIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794573423; x=1795178223;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=87/Ge5NhXdmtGpcXCLUvnqWpWEAxiW5M6eWOW+m4zUs=;
        b=eIHPyMJptIjEu2FfPlbHtJSX7n5B4Hdf+zOor9lgp/Z5dpijJZz/XmglTij+UgivY/
         yMWNn9qqz8MncGHyTsWsRVU+/dkTID0NxcRocEOrRDoCS33XjRarll1vqVplZE0voX3d
         JvNlGOXu/JW4oT/5s0n2xdXSaW1SaQcQxJND1Jb9d7YirZHSR5m/5Dv++btPfoUqFzBV
         LbFobUEtaOT3Ggk6qNE7FUxdLqr6jqVAI7r0FbUbRSSKQ0HJiaYQW3PMZNdrmrKZAt8M
         pFns/iv1CGv3VP/MJj/9X+PeEmX95alJN2xPRizIJB1sZQfg2eiajhFF2ekppkgZLjfi
         07Dw==
X-Forwarded-Encrypted: i=1; AL+hErGJrgnDQhV1PSTMnXOrgB5BE3qPXClVxuJYllLLBLVq5Wr/spFDuv2KZGR+8Jzobor+IVkA5FtGfnqlCIzp@vger.kernel.org
X-Gm-Message-State: APuU4Z9DlybrYEvwVVoE8X+PtM7PZhWdzlE4N20wY2pCZfzdtbC6huKq
	8OMiLKCfW22Q07HBeN4NvzgQP59N/r9KpNk9HjvvuVck1HYAVtsrZ2y2YUVPEclP1KiB
X-Gm-Gg: AYBFou1cgfK7l2NtoVUiX0kQtMu5w7jwmkkzMSU6djCI3jFp0TxrZxPEi65ri1lUO5o
	Wx1Xcpj+K0XnMsPe/scDIlEH/8WG7K4W1iBcoEWE0whKKRYqvKMi+CpfOY2HkQlsZg2TlP9K2X/
	TO9Oc+xbNEVt/jiFyg9YSxwpTBIb2wWkif2oqWfcd+VfVKq6LRNEY4cbPN9628CYP6TrcC6OUPK
	q1iGZXWB3DRFh0EbaK+QrgYuVIINgWbIzmZ8tOT4jhzGyoxiNWPFYyTiPCGuFjTs2C3wEXIU2t3
	qQSYe3yQd0jORbPI5GAFIVm7erQiQwcFfveYXPiQEZdClEsdJ6Fe7iSx2bp0AU+XgI4HjQYfPhR
	CkwuZmlKknYpWg5F3h+vIb07+XC14trjHApbHBEfzj/4RUUgAgxlqIMir2/izbpcjvufkoCUYT0
	qw1UksMnOruLFV8hF6t7880M+GWlT+0gwmtYrPy8msGuCVXPmdKeebsTN/eyR7hBhCWRpsPV1P4
	oQH05QTyLC9Sg5vrDkSb93hWREAtfxLifKYCpa3QL0jjN4DK9Xd1au9BdQy6ahDfR/yFLTe5Bq8
	DZ3wrGn9s4iK2637YaLiOmOJw9H/HRZuVNFNM7dWi9w3oWIhoFjw6n33mgWtEwmscXNpBXoekDn
	gFmu9DqFD
X-Received: by 2002:a05:600c:b86:b0:4b5:d95c:2378 with SMTP id 5b1f17b1804b1-4bb55ac4030mr49782945e9.34.1794573423157;
        Fri, 13 Nov 2026 04:37:03 -0800 (PST)
Received: from [10.0.0.233] (tmo-086-54.customers.d1-online.com. [80.187.86.54])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb55af2901sm57437255e9.13.2026.11.13.04.37.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2026 04:37:02 -0800 (PST)
Message-ID: <f12140be54ffc4d1e8e4026f80c41c75cf5727e0.camel@amutable.com>
Subject: Re: [PATCH RFC 39/41] usb: gadget: f_mass_storage: refuse files on
 pseudo filesystems
From: Alexander Mikhalitsyn <alex@amutable.com>
To: Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org
Cc: Jann Horn <jannh@google.com>, Chris Mason <mason@kernel.org>, Josef
 Bacik	 <josef@toxicpanda.com>, Christoph Hellwig <hch@lst.de>, 
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-nvme@lists.infradead.org, Alexander Viro <viro@zeniv.linux.org.uk>,
 Jan Kara <jack@suse.cz>, linux-scsi@vger.kernel.org,
 target-devel@vger.kernel.org, 	driver-core@lists.linux.dev,
 linux-mm@kvack.org, bpf@vger.kernel.org, 
	linux-security-module@vger.kernel.org, selinux@vger.kernel.org, 
	apparmor@lists.ubuntu.com, linux-nfs@vger.kernel.org,
 netdev@vger.kernel.org, 	fuse-devel@lists.linux.dev,
 linux-efi@vger.kernel.org, 	xen-devel@lists.xenproject.org,
 ocfs2-devel@lists.linux.dev, 	linux-s390@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, 	linux-usb@vger.kernel.org, Amir Goldstein
 <amir73il@gmail.com>, 	linux-erofs@lists.ozlabs.org,
 linux-kselftest@vger.kernel.org
Date: Fri, 13 Nov 2026 13:36:59 +0100
In-Reply-To: <20261110-work-loop-pseudo-v1-39-4c998976c6c7@kernel.org>
References: <20261110-work-loop-pseudo-v1-0-4c998976c6c7@kernel.org>
	 <20261110-work-loop-pseudo-v1-39-4c998976c6c7@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-0+deb13u1 
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

On Tue, 2026-11-10 at 10:14 +0100, Christian Brauner wrote:
> fsg_lun_open() takes any regular file as the backing file of a LUN.
> The
> file-storage kthread then reads and writes it with kernel_read() and
> kernel_write() on behalf of the USB host. With a procfs or sysfs file
> behind a LUN the host gets to read and write kernel interfaces with
> kernel credentials. Refuse files on pseudo filesystems just like loop
> does.
>=20
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>

Reviewed-by: Alexander Mikhalitsyn <alex@amutable.com>

> ---
> =C2=A0drivers/usb/gadget/function/storage_common.c | 5 +++++
> =C2=A01 file changed, 5 insertions(+)
>=20
> diff --git a/drivers/usb/gadget/function/storage_common.c
> b/drivers/usb/gadget/function/storage_common.c
> index 75831f2c7abe..83683ade20c2 100644
> --- a/drivers/usb/gadget/function/storage_common.c
> +++ b/drivers/usb/gadget/function/storage_common.c
> @@ -211,6 +211,11 @@ int fsg_lun_open(struct fsg_lun *curlun, const
> char *filename)
> =C2=A0		goto out;
> =C2=A0	}
> =C2=A0
> +	if (file_is_pseudo(filp)) {
> +		LINFO(curlun, "file on a pseudo filesystem: %s\n",
> filename);
> +		goto out;
> +	}
> +
> =C2=A0	/*
> =C2=A0	 * If we can't read the file, it's no good.
> =C2=A0	 * If we can't write the file, use it read-only.
