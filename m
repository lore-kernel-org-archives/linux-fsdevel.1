Received: from mail-pj2-f14.google.com (mail-pj2-f14.google.com [74.125.227.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B34083D3CE6
	for <linux-fsdevel@vger.kernel.org>; Fri, 25 Sep 2026 17:07:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.227.142
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790356068; cv=pass; b=dlmuDbl8ylnf2nsAzeXJVOPSANDUXnpwCRCCfmAJaZO229AHCoep1FIXav7xuWsQiVymIh0bk6aM5WxQ+lwrZbwHXd5MDky7C7GXnKjzfMTEF99WOUTm72Sys58eDhb0J82IwvqpigJmIy60v+UVn2iHtBbyL5sfA2ohR6Xga7A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790356068; c=relaxed/simple;
	bh=Z/QlDjEqmTsvd8hmVsRhjPJAPZKduCsAshcn9SEcHsU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FtKkcxMzGUNljJms7SAF0NQbQeHNxPjTKCZ20oWAFCN4HDIvZ1n4slBNOFantsiGREZ0KzticrgVuNiaeOY+RderuE2UIyEz97ChdlSRcPktqJ6ZPYsPVUZxXEKXK6hw1EHDCWdlH2kQx6HZikoZl2rwBrY8ViZCbFCGwS+lnaU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=JQ7vBslB; arc=pass smtp.client-ip=74.125.227.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="JQ7vBslB"
Received: by mail-pj2-f14.google.com with SMTP id d9443c01a7336-2d747f05ffcso5102855ad.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 25 Sep 2026 10:07:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790356042; cv=none;
        d=google.com; s=arc-20260327;
        b=iHQrw+hSguWgzaUKmTFYQxP/pzddC4WlGmEOaHLg49sD55n6PAprEgwb9sOovjqjme
         zG+JKnYV8D2Zir47I9NsVHECXnzh/QMuP5/5OdQQsYnU0Mm50XMx57EBM76My6XIDBU2
         lGJWtPPVOnVu80NP8ZuH8HU++C9D9mroVpRubu9Ro/OWQf596TrLWPH9WNIWxUNN+S8g
         S9dWIhYb/z0DDsr6FQ4fw+Wi8z47RJ0KhN1v/XXzEI9fZCltnFs55pi7Q0aZoPBpihnT
         PX9P61ExONHAECLOZgCJ682tpS9hvrN8iVNtd7iKcdX6ZYTdiRBsvfrx0QEpI1qxCNzT
         OZOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=8YwzIASUiQRwU6GfvzkJObDJseuyBEMVP7g4XrNm/58=;
        fh=E30hxUsb21/XurW+sWOISAwvhltNCpo4vFbpUGaxBrY=;
        b=JlPbk9XC+lIQk2TvsQgeEjpxubFoVlJ99qm35Hh/C1H2DvPaWtYe9GPj3m4rlJGtP+
         Oh3tId6TCGpZfcEHRen+pIC9YGLXh6j/T0As3VqemHqiUilrwz8K4CP8Q4BGoiu7+2zd
         b65OeuTxewKsiPqCrwOGXkEZjh505t3kTQMWZjR0hGosiaUq4BeAHWZ6SupeC64ZYA6V
         qvMOlDl8dqjaPe8GDIM9fgkn+2OLJr1sGzeal5Xxlyjlgtfbscqg9QC7c5glDLBWLVOp
         /aBGaStp0FwNSJkhUe4TTJNcg/K/6puEuDAMJkXz/zH19A6urIcLGnDj+VeWH6unT0MQ
         9XEQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1790356042; x=1790960842; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=8YwzIASUiQRwU6GfvzkJObDJseuyBEMVP7g4XrNm/58=;
        b=JQ7vBslBA75Oz3vhccuiegu2ZSCVFqSF0HyjC/3/vNzOkrP+yD6f4D4JjYMSYAoFrr
         wlg7Wmn6oEu7SXRotz0a67VZfHRO6XibZ9ZQ2iaB3D1nQj3Xnbu+DnvAmLPuwuabcTJk
         PXz37aU1zp89S9iK0/x3WEyWrQZ8hNLRiSYpSLIsFe52Q0ZtYHr08wUrk94pc3ENWlQd
         J+Tedgfpmw+/PX5h3yjumGEOqc+s3rcWYPx4Hn4luwZxasnr3NVcHxFxvCE/jfitgeBw
         +jOt/CmP2fD13Y486VYHbVYAPN3U4OMa+qtVuZhbWJD5jm5g1hu0o/Zq9FL93oXYU7V4
         vv7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790356042; x=1790960842;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=8YwzIASUiQRwU6GfvzkJObDJseuyBEMVP7g4XrNm/58=;
        b=Tm46eIhrgGr68MyJDQ1+1smJSj8gY1ZJOkNinutiawvV5nktGa5wzyR4ZiCxMdV6Rg
         0BY1wPigNBPiL6asl8JjZKQh59VQxZCjLFrEVJIGNWavf4u3uLEAndBKQOWtyogKmROF
         VL2UVymJWgbI4qtbAUY3h7eom8WzEPdTCTRANIb7H57/81DmtMLaLM8lyVZ62yEiSQtA
         F8GyxzyC3LrzsoZdrSjyHZ4o4zB+W9R/JLW0igcptnzq8yYzIvHBGqaI51Vu44mD1h2b
         p2RsJoOCtAD9jMst67bfM0W/eVteTr0IPSsDoNeWGYwbS/btFs2xrosbie7CJKU9ufMH
         a5kw==
X-Forwarded-Encrypted: i=1; AKwUvBxbZZXALcO/b7putUHgs5xuW2RJ6dNZixzm/kLMAHSX/gB6U3icRy1YFWInFSKM27PsDwNtaziH/gmzlrms@vger.kernel.org
X-Gm-Message-State: AFuF++lvrWXR7EM86JRzohvCIJiqB3rGpiKU8z4S/l8BfApo2POpaaPC
	9e/0s96JokwjRBlEVE0iPjpzdhKhq6ht7nikUqIjgOxcBCII8fiRwaGSJllqjCMHrg2phNBJ4G0
	2AlCGcw3UI2sRy/T4PZyTCRC/1fqIpfUsyez6H0uM
X-Gm-Gg: AYBFou1jflVXfKYiNtvOtAxP8XvYd4t5l5QD6mt1wxr4oPeyD6Gy0YvVvZLC88hxzM4
	a8T9czBgWF9Nm4ExE5SGUY3GS16jWNYZm6JlJnWfaCPCBFbaPuB276m1dDxYUkpJix3FAfjQ0LZ
	ghUEeBff7n4jS7XppNypueZSwG1TWibvQthEb+OdcD6k97Ad/eWbQ+wREhdB15izGY8ChokGivO
	cf8pzvRX1Az+k0l1BJuYo8ZmFVEH7Xn5Cs1+VS0N4rxinVzKz2qLEsqqg1yPTkX5LmKhoQcYrRk
	gReSu0E+w6nYauZ4poOI25B9BAXYv4+BOIp6c8EzjfUBVmDZNSKyQcHMiSnS4ahLxStDkDQwovJ
	XwGYAsmzScdOY1NK+03WICA==
X-Received: by 2002:a17:902:d48d:b0:2df:99e6:9448 with SMTP id
 d9443c01a7336-2df99e695bbmr12902675ad.61.1790356042370; Fri, 25 Sep 2026
 10:07:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260924104831.1081137-1-caixinchen1@huawei.com> <20260925-zahnersatz-hielt-lerche-141893658522@brauner>
In-Reply-To: <20260925-zahnersatz-hielt-lerche-141893658522@brauner>
From: Paul Moore <paul@paul-moore.com>
Date: Fri, 25 Sep 2026 13:07:08 -0400
X-Gm-Features: AclHuK-PYyMWIn_xv6i13K6lF_3RP26uUOO_mtAnUMGHNcMrV5ydBitx8qn_ri0
Message-ID: <CAHC9VhSeXmOHvioZ12aVmnOtpP52-G=K_jS3K0fTSiCrDHStPw@mail.gmail.com>
Subject: Re: [PATCH RFC -next 00/12] landlock: Add READ_METADATA and
 WRITE_METADATA access rights
To: Christian Brauner <brauner@kernel.org>, =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>
Cc: Cai Xinchen <caixinchen1@huawei.com>, gnoack@google.com, jmorris@namei.org, 
	serge@hallyn.com, corbet@lwn.net, skhan@linuxfoundation.org, 
	rdunlap@infradead.org, gregkh@linuxfoundation.org, rafael@kernel.org, 
	dakr@kernel.org, dlemoal@kernel.org, hch@lst.de, axboe@kernel.dk, 
	viro@zeniv.linux.org.uk, jack@suse.cz, dhowells@redhat.com, code@tyhicks.com, 
	linkinjeon@kernel.org, sj1557.seo@samsung.com, yuezhang.mo@sony.com, 
	hirofumi@mail.parknet.co.jp, cel@kernel.org, jlayton@kernel.org, 
	neil@brown.name, okorniev@redhat.com, Dai.Ngo@oracle.com, tom@talpey.com, 
	miklos@szeredi.hu, amir73il@gmail.com, senozhatsky@chromium.org, 
	chenxiaosong@chenxiaosong.com, zohar@linux.ibm.com, roberto.sassu@huawei.com, 
	dmitry.kasatkin@gmail.com, eric.snowberg@oracle.com, 
	stephen.smalley.work@gmail.com, omosnacek@gmail.com, casey@schaufler-ca.com, 
	nanx95726@gmail.com, djwong@kernel.org, daniel@iogearbox.net, 
	linux-security-module@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, driver-core@lists.linux.dev, 
	linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	netfs@lists.linux.dev, ecryptfs@vger.kernel.org, exfat@lists.linux.dev, 
	linux-nfs@vger.kernel.org, linux-unionfs@vger.kernel.org, 
	linux-cifs@vger.kernel.org, linux-integrity@vger.kernel.org, 
	selinux@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	xiujianfeng@huawei.com, lujialin4@huawei.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 25, 2026 at 11:33=E2=80=AFAM Christian Brauner <brauner@kernel.=
org> wrote:
> On Thu, Sep 24, 2026 at 06:48:19PM +0800, Cai Xinchen wrote:
> > This series adds two new Landlock filesystem access rights,
> > LANDLOCK_ACCESS_FS_READ_METADATA and LANDLOCK_ACCESS_FS_WRITE_METADATA,
> > which control access to file and directory metadata such as inode
> > attributes (mode, ownership, timestamps), extended attributes and POSIX
> > ACLs.  It picks up the work from the "landlock: add chmod and chown
> > support" series [1] and follows the coarse-grained grouping discussed i=
n
> > that thread [2]: instead of separate chmod/chown rights, metadata
> > operations are grouped into one read and one write right.
>
> This is mostly fine for me. @Michael, for the fs side of things I would
> give you a stable branch vfs-7.*.shared.landlock.path that you can pull
> once this is ready.

This is in my queue, but I haven't reviewed the changes yet.

@Christian, I'm guessing you will merge patches 1/12, 3/13, and 4/12
since those are the VFS changes?  Once you have a branch for that, and
we have all the necessary ACKs, I'll merge the LSM changes in 2/12,
5/12, 6/12, and 7/12 and then Micka=C3=ABl can merge the Landlock patches.

Are we all okay with that?

--
paul-moore.com
