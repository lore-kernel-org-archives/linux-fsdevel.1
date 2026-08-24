Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C042B3A7848
	for <linux-fsdevel@vger.kernel.org>; Mon, 24 Aug 2026 09:49:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.175
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787564981; cv=pass; b=k2U+ycDJjz1kSdgKB4Zh588vZfPmAB2qdlUWIBR9GG2hWPg2mxG8rdZl/5egIVkFVtqWI12+bHAe8+h17eu2mHFu9/JuHhj8ReUOG97+bfA/KqrmwnFw2a9SDWkKV4VIn8wl3sQbZ1hYuAFyitJo7yxb38TP2XffezBPl+HY21s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787564981; c=relaxed/simple;
	bh=f7zLB78qgfsXeXkJUI5zyv241QNeBkiTpmVwCFsdDjs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Z3GfoVXhqY2nFi4ZUNW9wwU7Ab4gfriimrMGFNAYB2euIOp97p8YAkJBWnskg9QvnbwF2lgtMZMLBxXIWV0W+nkIVNUlCt1L08CvCCeh8nwYuX38AdWyvavS8PSS0bWF6gFx+2XODk1MVhlgHq5ZYDsqfQbqoz9DV1PM54ZtjQA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=hpfuzpH7; arc=pass smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="hpfuzpH7"
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-51c05dcdf49so31220591cf.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 24 Aug 2026 02:49:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787564978; cv=none;
        d=google.com; s=arc-20260327;
        b=qb59JxVggDGwRLMxVxmDB3bKWtkijljSHtNYYbFQKzqdnRBcdVZWXT4fEFJ8cf5Qcz
         H1Umaq3qkiUGwK00z2Jhdb42IAr9jo45b4A9nmOjXc5k9QW4+ikkWlwvD0L+6zsEUjFn
         zeqOLswveUrdFF2cvXJ1hrhULzVD1MzdnKa+EwDXwpKKtXIBOnp6c9uFoH/g7gulwLTT
         R7kYLDeEnXIoPCYmTbmyZqsVmsrQofS1D8xCxu554GnSNeMCmViQYtD3SybaYN3GxJPH
         2VeTLOes6JKXhmY5pjCyxyCRJquo504aHMMoA5z0N2XMvK1TBo8dETOBbMzfX2Zk81fC
         fESA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=iqA+Vodt4zn8f6pvRuFDvrg7Iu6eZrCLtVsfmIZOyfA=;
        fh=ugDacDIbHmR8JUVREhVVt1YfV0MWftLhcxMdmTaK3rg=;
        b=Nydz9ldJez1W2RkrPuf7U1VbohlJNpSCXb8cAoNQAdmTPdCgohHRnwPVrdJ4HmUGDk
         ezklwJnqfy9QMeZeGU6RPwpeqN5c1XkPQ0RahsBV7XOGD9l7iHZkxWxWcjW3ZezUQnBg
         ha6Ju/cj/LfD5FIq4iaTo3gQU9Lx8Ml2bNL0S+rOKAOKCq6St9oTW1Ts6TI4iIMNDYq4
         8hanDjn82niAoUtCliKCJqi9NGWPkdXN3gS/cmqyjwQRb39Ssu+UlHbHHvTAugF2Oci5
         il6NbORwRoLDRfL0hDjE7OLCKRvPrUhoL73b1biT8k4sOMpzqKhe3Ph5ZKwSvCrT8Rdh
         uPeQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1787564978; x=1788169778; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=iqA+Vodt4zn8f6pvRuFDvrg7Iu6eZrCLtVsfmIZOyfA=;
        b=hpfuzpH7dAW0uvOb7Sy40AR3iosxCENVFN7yT033bC+A8maLH8sW2y0Xi3sqedpHOo
         ymxDdbU+xjNr18fPiI9pETto8k2B7MlZXD3SKMz/aw5cZFTjc/xSGJMKIa0n5d17+IEi
         i5ViHUqI0lsXVaGvSyqDa84G8QMmAAQj3aGS0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787564978; x=1788169778;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=iqA+Vodt4zn8f6pvRuFDvrg7Iu6eZrCLtVsfmIZOyfA=;
        b=YRTpejhxhoPtTDIaGvva21soq/MZFD5pwwgY7OcYZEfJMchfFUDCy1lMbkB20cFTUn
         AiePIkJteT8ASmYHJAAdt013igkTe743XsIRjg6cfZeZZkak4CzXSozz3Dq9XeKXDKOV
         gJuih+IxvC81OMmCyD1GNKPXa6Al6vJ90Ycu7ElNl35dHjlRE3lCaSbmdDZx9RPSL/7s
         QQOgszDu8jnZOG6V5N90yixhs3tkrMu9IVuDWzWPOdbbQAu4AccWzwQ71579PL0eZQ/V
         Hdtc6rCXknvL81NMeeSkvwyPIjgt8MIOwxzJ+41muXycJE3Phinq43ntA4jTxuDEcFql
         v+Cw==
X-Forwarded-Encrypted: i=1; AHgh+Rr8iFnG/Y4p5N2etWJPZLbc7HB+W/+qVgvN1Lc6hLA/89pBgTr+9O5+yD8oTTACS3zDALiA9+/ukJOjQOmB@vger.kernel.org
X-Gm-Message-State: AFuF++nn981genIgyruflwhGz+xyed1O3INx0MOFnfk3iRRR2zub27O5
	9Kthnh8W1x+Xc4oNG2fnVoE/zBoPI4YPvkZywuPwME5mUGj6hvoLpGel4TDgrpUxITvGdwYnLH3
	GInVen0RFMGeF/3izdyL6cs79tafPJlvG6h/ueKhdqKa8g4IViD5arcTeUw==
X-Gm-Gg: AR+sD120QCzw5Sa5EeebqId01cUYzH8WdYgFVmBytnzt2jR8dNe5LilcU6/WhYet41h
	4D0ec9FAK59QOY0MsltngKInmzqSMRsJdA1uyfEAbSheQvZ01bD6NKCEUwqK6W1Ko0b0CH18OVn
	IXlykEGir9U5pigzlHO0HEH5n/1r59A6NsAJn8oc6nTo3q8QgPaBPUPa1N1p6XZ5xMDZwRLhz4h
	6bTMvzhQ7K5N7qVDSuGuTqgkTG3T40/6s5qwihAqPzOoFeVV7WxOPeGB2TpTJbx/82BLFXbCRn2
	FI0+V1Z4IjN2GZ38m448CCyYc+kxzeiHVsmDQP9+PjXdID3RfGmqU9yI6tHwzC4AhdVuamR5F/9
	1JQ0=
X-Received: by 2002:a05:622a:314:b0:51c:981:94a6 with SMTP id
 d75a77b69052e-52e09cabcedmr166055741cf.23.1787564978195; Mon, 24 Aug 2026
 02:49:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <2026082150-autograph-perky-e3cb@gregkh> <20260823224256.2724025-1-fahad@codepure.com>
 <CAOQ4uxjhfpNVvoVrTayj46H2CViTOc3oxzM6xdb8+E7ikE2CSA@mail.gmail.com>
 <CAJfpegt1WinKmP5nOGv8Yx9VLf4Mk1ojg7e3xR5iUz=7yDAh0Q@mail.gmail.com> <CAOQ4uxj+GRa8CaCONwPQzLCjx=R8MRr6PTYYC+QW7VrK0PEhMQ@mail.gmail.com>
In-Reply-To: <CAOQ4uxj+GRa8CaCONwPQzLCjx=R8MRr6PTYYC+QW7VrK0PEhMQ@mail.gmail.com>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Mon, 24 Aug 2026 11:49:27 +0200
X-Gm-Features: AcwNN1XHPbV5W42Fv0eyXcWCG_2PycHva_vfR9-O3H1AMlqLqtB39n_N9b-Q5EU
Message-ID: <CAJfpegsVoUyqy0dYkTvBGRZvgdv_nmzmCw_uF+LP-Vq3EhEkSg@mail.gmail.com>
Subject: Re: ovl_copy_xattr() can write uninitialised heap into the upper
 file's xattr
To: Amir Goldstein <amir73il@gmail.com>
Cc: Fahad Alharbi <fahad@codepure.com>, security@kernel.org, 
	overlayfs <linux-unionfs@vger.kernel.org>, 
	linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Mon, 24 Aug 2026 at 11:30, Amir Goldstein <amir73il@gmail.com> wrote:

> It's not really a retry loop, it is an opportunistic buffer auto grow
> loop, see
> e4ad29fa0d22 ("ovl: use a minimal buffer in ovl_copy_xattr")

Ah, okay.

The logic is too complicated, though.

I'd still go with a separate helper  that gets passed (..., void
**bufp, size_t *bufsizep). Single caller of ovl_getxattr_value() can
also be converted to that.

Thanks,
Miklos
