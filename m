Received: from mail-oa1-f47.google.com (mail-oa1-f47.google.com [209.85.160.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E863131DDBF
	for <linux-fsdevel@vger.kernel.org>; Thu, 23 Apr 2026 15:29:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776958173; cv=pass; b=rpiWPdGyj4zE5FQ+0bmaipAKz98RdrYiILpNO5i8oGUtkPYuh/yeqs37kB0EgyA2yNfvg5e4JjY8+DnsBZAhNQFuyqibIqQtu7v6pDOpEfXt+1Wb9OCUOudc7B5rSx5ei03CCtFwa/oUlLDlp/hx31owqc0fkXJBC6/k3xMyS+c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776958173; c=relaxed/simple;
	bh=esi4JAFZY7P14gamD3fgFViEQxYA2w73zBbzZV45vsQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GvH8wm4GO0b+11xgPEgnIEK8JTf9+/bzxgpAZwyNgJTCFnY5ecP5gY7p0FpZqSwVzLrLEyPNHfDl6Pa/c6yH5xHIGNPVxbxsPCKEPsPufWmHc2Sg8AJ6wSqv9hV56JeLoCjtiHTh+a+pOmbSvMInt4OGuVr9UcDEAImjOzGIC28=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rVqbdrlf; arc=pass smtp.client-ip=209.85.160.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rVqbdrlf"
Received: by mail-oa1-f47.google.com with SMTP id 586e51a60fabf-4152698e745so2491603fac.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 23 Apr 2026 08:29:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776958171; cv=none;
        d=google.com; s=arc-20240605;
        b=cLE6o8V7mOFUuxV3q3sHw3anZn3OxGjYQrec69Oa0Vcoz5UibU/j3z+H7fm1XpcyZN
         X3OFoQSUiz/PwSWkMSgzLrUB9/9maHjuFBy3pUrz/Por9HPc6YzL7cYUohfBzvmdlrxv
         lcR4ZFp7ZHgrz49ozt+WGNQ1ycYe3GLGIPSZmQAq2t5borCjroz7gqYwUkKtK54wMYQM
         GZlVgSf9dYO76jX+bmMTvBoU3oaf7BMpdUP2ETQkeJ1uPQOREMSCua7m18FazD0WVg18
         L5d3/eqyU5ZlHy/kC+qXWB8JwRIUUROAR23DlxFkBMB6SDBYPy2tJMerowbu3fW175T5
         A5AQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=esi4JAFZY7P14gamD3fgFViEQxYA2w73zBbzZV45vsQ=;
        fh=JQWTlp4US//oP5AWQESdsU/mgTZsBE2T63nJDQ9W7Y8=;
        b=Tc1lGz+j3X44iK5cpFIG/Mr6o0gd5BKzDQWRRot2UEbCi5mqC7TOg9XK+E3bGjKRmU
         Rh4LZHG/RBnZAJqxdczoYAaXn7o84D0pkQbHTlQ1x8UiZNexQ5XLUwp5b+I0iUOKtLF2
         d4TF2j/5ikYfjX6wW2sDBBSHjy9dPVwUbBloBi4MoYsfAaKCQO+kP0rAY2YiBPjrHVxp
         PzN8f/BFgLHdpCWS9rlBOCN74oiQsMvY+jXTB4ET+mRioTB0MmuNWTATUcyEhCSw64LT
         KKfesnjqYXrNQ3zzoPc4SdujpsptKS2sKoVVmBzlMSXgn7n4sGAgqYgoqYuE5XyYdNPm
         yNvw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776958171; x=1777562971; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=esi4JAFZY7P14gamD3fgFViEQxYA2w73zBbzZV45vsQ=;
        b=rVqbdrlfDKMqLbqimmsdiV3LCIA8FmOC3Q/DOm4JiSiDDLJkVTM0RNcYPmgAL3y2XM
         LlMbNGeIHD+89O49nsNDXA1GvWB6OZ5h5rSeeJ9lBXZ//LDfYwWcS5Vv80h3zoeOi9vS
         RUxAeU2mhJ+xkRUTXI9n3SnF3bByVFWrHcwmTk4kU9kobqz9JgtZ29TZZZOn6/YOOrne
         /uKZNIXxVGa6X6/mXqddiDNASt5oRUmKc1/fJ9vlsgKDl6AcyrRY7yXgTduUYmCbEXE/
         AGPJ0fcMILJyzhpkH07lYc4ZhlMx4dDj6bEEVy3UqCpzQUwnTsOP9+c84TuxeFTCeUEU
         z/QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776958171; x=1777562971;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=esi4JAFZY7P14gamD3fgFViEQxYA2w73zBbzZV45vsQ=;
        b=GdwjpKnq4cULxJkZliiUotzUwfkhDrsMY6AB0Q/LGtCKU2F3lTv+L/n91V6Yb+JneH
         JFyAEb7PtVoPJkGacH4Rlvx00c1bEhTHtsgxw23wxZnnoqpVvjD60wcEMDzXoL8SMOnk
         yVw1zPpS46fdKgChC4bzwlrcvw5a3V3v+ypbWateX/17/7imY6mzzF06ooB+gE+g80PF
         f8DMve1Xy0jpqUuU1dnqM29ocuhxWosdkovP1rmfBQxEUsn8qE70WsX2QYYmX3sqOTks
         66k6gTyfeJMDKjyvI4GYYDtYo/LgTq7rmTIqzs+8p54l0l5xf9g2awZ7ZDFh+UEVxNJr
         oNrw==
X-Forwarded-Encrypted: i=1; AFNElJ9jal1whpa+G4U5wSULWVYlqAkxDBm5OKIHljvgHwzoLg4UtVM/2FfojPIzD00eiQb1zQIr00G1158NL+Aa@vger.kernel.org
X-Gm-Message-State: AOJu0YzZcL9t/h45ybvGLVjIZQI+3YZsY5omcl5sQtLQFU/0i7K4QRNu
	1ISJsh15KNK7WDHhZmR09EPmTeV3tS9CMqwzjUeVW4V0yR5fNHWbcCCAY+wrGefb1UPhkraueA8
	oLvqFMa6YP33vzz/1vrvAyL2nGNS4FbE=
X-Gm-Gg: AeBDieuthVfzMOAosYYFMfWNPFZYwaRmpsupIbaNh8kRS6v/JgOp1Owf9qCkfIA75g/
	PSBZq+IALflu3hsdq4km/37+Uzj+cMoxwDoQyuGvBL2BG7p7ThPP5IFti7Xa+/QPaN2yuKlo7x6
	GTXKVkVY1/1uRFpgRHyxOQE3yIEGSGJzzbGKnHH4PsUDYdcV2nTJG5OuaUFTPUtYDS2W932p1qN
	SRX4NPp46JAoXSGoMabtYnu+jaq8ZF4NQigH+nIXo2991htblOvP0P+ms7Raq2YUpESne7ZsQ3d
	vJURWFmTV8BTGOWW3GxGiMCn3195t/iIBogVuQpT/6frHV0bhrKJnFIx0KZ5EQxwqSHADW7Pf1M
	Pfc+QnZYVqK1Eec6I/tol34kJp5LQI673qWo4QQ==
X-Received: by 2002:a05:6870:659f:b0:41b:e72e:c115 with SMTP id
 586e51a60fabf-42abf21185emr16932734fac.1.1776958170691; Thu, 23 Apr 2026
 08:29:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260405011920.28622-1-adinata.softwareengineer@gmail.com>
 <87y0j2m1d0.fsf@mail.parknet.co.jp> <877bqbeez4.fsf@mail.parknet.co.jp>
 <877bq9lyk7.fsf@mail.parknet.co.jp> <87mrz25hnz.fsf@mail.parknet.co.jp>
In-Reply-To: <87mrz25hnz.fsf@mail.parknet.co.jp>
From: Adi <adinata.softwareengineer@gmail.com>
Date: Thu, 23 Apr 2026 23:29:16 +0800
X-Gm-Features: AQROBzBmnL-JC9cNkWVdzYxtZCb8HXTQ2QUuUaVK4XGTPvBwS-tLU0t1ditvZFY
Message-ID: <CABZ6vuD8TWGj0RZ8j21VJ0mvQvzcXE0Tr0bWnYENHDUwQ=Pxtw@mail.gmail.com>
Subject: Re: [PATCH] kunit: fat: test cluster and directory i_pos layout helpers
To: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Cc: Andrew Morton <akpm@linux-foundation.org>, Christian Brauner <brauner@kernel.org>, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel-mentees@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

> OGAWA Hirofumi <hirofumi@mail.parknet.co.jp> writes:
>
> Hi, Andrew
>
> Could you pick fat patches again? Christian's path didn't work for fat
> (no response for 10 days).
>
> Thanks.

Hi Hirofumi,

Thank you for confirming the commit and chasing for the merge. I will
loop in the linux kernel mentees mailbox for the Mentorship programme
requirement. I hope this can help with merging fat code updates too.

Regards,
Adi Nata
