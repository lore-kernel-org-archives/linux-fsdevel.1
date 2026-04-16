Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 057E537C907
	for <linux-fsdevel@vger.kernel.org>; Thu, 16 Apr 2026 12:12:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.219.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776341571; cv=pass; b=RHvwBD+kUs76DJUUozwA0VqDG44nV2NivXadq66EKyq+e9ZIwQqyHaq8O6BSIMqA1kf+YfG10fCnPflr6AhVGFUlArNKoH0FR+50aECLu/ERpqoDPvlmzWniKuDs11UZHpPqUwXkSwFlcFl2q6N6zCSly0BBq7AhOTNtUMh/b68=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776341571; c=relaxed/simple;
	bh=xs4hGlZiJqAV9QCGrkSslLomiSfE5gcr4xqzLhglwS4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sPQKX0fvy3wVoYqzMtXP5STvviC2fqTGziEuabrimoMZ0M4iovD/+AxEP9R7v2jp7fkMHm7Ll36QTw4tC8MHksaZBno1AgBjnZB865xujL/Qd3LNB43SwJ3lQPYsvoS3b8ll5kM3lAoEumUP2fiRopdl2e2AILOYDvpwR9kohhk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=RZ9WT29H; arc=pass smtp.client-ip=209.85.219.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="RZ9WT29H"
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-8a016799d2cso85057856d6.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 16 Apr 2026 05:12:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776341569; cv=none;
        d=google.com; s=arc-20240605;
        b=gERHLxGlmzGzlMR0pfH0OwsaxACu4rpKPh9bSMe2dVx5sI0PfKl491bV5kdctpFweU
         nV8V1KA32VGJtG14JyHvfDrF+IFXaMfhaAdYZvY+BpCeetglafQC5rQVCzqidlSXdxJF
         Dcl7lnE0ftrkRVx3H6VfjTyVrb5MrlI1DHomCUKUw55GgM/SmP0qkXctuHkc8WKjRG2X
         XC9rmxI+7PMy99q1DAKqxd9er/rytS+NmiTzRvQnaDHEquRp1xMDVeY3U7Oo2g4RaKnB
         lMkOhfkaeVS7rJg9ljMa98rHdKB00nNy8m+N+WGzLoJ2u2ZryRBAOwCHD4wS8sC0BPiX
         R6Ow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=xs4hGlZiJqAV9QCGrkSslLomiSfE5gcr4xqzLhglwS4=;
        fh=ulS/a58fScvHw9iuY/0kz6ndByQebSMkzJRDY3Q6h90=;
        b=IBEX7T0BDUveCsi+tSYImKfVohzp+d1SnDAyDHW7eO9Q/8Cb9mMkcE7hQuRAwMNG9M
         D2lZrob9lPOH+ZhDabKidMJYmEkZvDrmZ/Umgw7GccyRo4XrRA3NH0gUsxh9CNY8m5Xb
         TF+TUIFoa8hGjafxTZ0bKb0URbp8fM+BtpTGYPz4MmD8d20VC69Bc2b6Dfu6QFMmUSwZ
         ygk6SuVXLMLTu37ZhMuFAwc8oRbtEOZBbr4he2EV/zAy7GZYU0uIkXSJ5/lydo4pABRU
         15bIImG+j/wBjCgD2Lyk/wUfkGF8pW0koUyrr6Ab6+NeZN9XKNFRU2/KdhohzxV29Ulm
         Tf/w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1776341569; x=1776946369; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=xs4hGlZiJqAV9QCGrkSslLomiSfE5gcr4xqzLhglwS4=;
        b=RZ9WT29HDnw0UKXOo5xuuSyTGSCO2J1bLX0/MF+H7dy2EH9cb+MPSaqJnC3i8V3S4/
         UKoFvVUsrXNB/QMqMeDNUVTtkn2Kg0ROPi0/LeM6eDWEULZGlGzj4sLHNiCHXop5UeRs
         sT9zJ0FdZOUTpeZLYpHQlaHU8/U5APl0PZ9V4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776341569; x=1776946369;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xs4hGlZiJqAV9QCGrkSslLomiSfE5gcr4xqzLhglwS4=;
        b=Vm2a4d3rr09T0JKPVtmd72pqyhw/uwvYQbm+1ph0gJXZHXGsXUWhRFWGMigxnxjAwE
         XVpbLvxQ176Yz5Bkfn7cUUDWqdKjVKQCPgRmqEoqrjU6fACpE9NAJyAzN3XM8DaQtdnJ
         ICt0fojB2oqcnKOzQ/I6tUCnA1oo14LmAtrUDG/qslC2wKQ4p8R4vNbBpo9uKUYTciZV
         L0nUOttloc64okpE7CzBzfDQaMikH9rEFHV4LqV1pDaY59terH6An42+1VwFKtUZHBut
         QjgSJJ2pC3PqxxkrcPzTWuEz/HYmx6P4ubCkph8JuJRlpOOt7doS/ViesLV2CgD473gw
         osBQ==
X-Forwarded-Encrypted: i=1; AFNElJ+W1Wje9hUU8MKSWZitkVp6K9txJ1bHvi6VutwOiB4Wj7kwO5CVWR/1eONUOiQtWJWmAG/FtsuVcKgWWVYd@vger.kernel.org
X-Gm-Message-State: AOJu0YzfOyLQTabqLE72UTiAqcpHI7lVgs63/8lWmMDhPgrxD/RsL70B
	epuIY16pfOEa/W7kAPtTOQJyBKDSiWbD3hv90BY0DSAF4eRPDrVroeVKx/SWyVrcVr7mt5hHi4D
	sKgOCNG/quF0sw/YVYEHPr3IqNIcHui7/bAwIePOvzrC7FVoORXIgmzM=
X-Gm-Gg: AeBDievVRmvGhBKMnsABSe/TzhD9NDmRJtLlGI4sVTqtmODZtbh750aTxVg2pTzOIm3
	lfxn1lKVerr6D8LoIhtIHZ43n1B7X3WTQqXB6wGFBPER5hcvEdhFam8YMi4o/DcbKOzMgg0Dwk4
	E7ZOxO84UPAalpCaVfWlH22ufQZwoxQduFQTydnN3j7eVcOIEnr72+5UVtpQAk035l3dUNAnm9c
	lY1+D2/8iASQDxh3xR0PWiffP7Jmxit2mjcS05GCfyAeuxvim4UMBj8K6Bi6eGYhmiFKoyRn2oK
	Qs/5+4xwpPb3VcNpfa6Xeq0RdBjb/Jxo5JMd
X-Received: by 2002:ad4:5e85:0:b0:8ac:bb62:fe5b with SMTP id
 6a1803df08f44-8acbb630feemr194285446d6.12.1776341569011; Thu, 16 Apr 2026
 05:12:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <898a4e10-6193-4671-b3b1-7c7bc562a671@fmap.me> <CAOQ4uxjoS-PvnZ2poh0bx0C6ocTYwuEpfV0q5md15SjS620OMg@mail.gmail.com>
In-Reply-To: <CAOQ4uxjoS-PvnZ2poh0bx0C6ocTYwuEpfV0q5md15SjS620OMg@mail.gmail.com>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Thu, 16 Apr 2026 14:12:37 +0200
X-Gm-Features: AQROBzBX4a19crGk_XkETxKLhmewGXqK0FtKuy_vUEQL4x7MLk1p9L_bODNm4ek
Message-ID: <CAJfpegvxF7F+XKFKokSH4eOgCA0V2RNm6B54MS9nr9wG=U66OA@mail.gmail.com>
Subject: Re: [fuse-devel] Debugging a stale kernel cache during file growth
To: Matthew Wilcox <willy@infradead.org>
Cc: Nikolay Amiantov <ab@fmap.me>, fuse-devel@lists.sourceforge.net, 
	linux-fsdevel <linux-fsdevel@vger.kernel.org>, Amir Goldstein <amir73il@gmail.com>, 
	fuse-devel@lists.linux.dev, linux-mm <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"

On Thu, 16 Apr 2026 at 09:24, Amir Goldstein <amir73il@gmail.com> wrote:

> > I've recently encountered a weird issue with JuiceFS [1], a network FS
> > which uses FUSE. tl;dr: when a file was being slowly appended, a reader
> > of the same file on another host would periodically read a block of zero
> > bytes instead of the actual data.

Thanks for the report.

I wonder if we could clear PG_uptodate on the page which had its zero
bytes exposed by the i_size increase?

Willy?

Thanks,
Miklos
