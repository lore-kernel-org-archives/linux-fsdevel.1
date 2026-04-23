Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2866D2ECD1D
	for <linux-fsdevel@vger.kernel.org>; Thu, 23 Apr 2026 07:34:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.177
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776929667; cv=pass; b=E1+J5QKDV4dcdQUxSs/gpFM/a+2PWN/AO+ThgE1pTgESskYckz/3i67UNHpxckRrKsBsRNQ/pY73OmtB/wnbsIEMB8gHXpjVFiRr+ljHhn5fxduZ7EdgzvJ7N1pLq57ZpzDMeMb8hLWJ4GnoAbpGyndAtUPxCIohSSq9yJQatcM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776929667; c=relaxed/simple;
	bh=ZTFDX2Y5X/u5PrIiEY4oYQusbXnMRn6UB3PQ0KhL9js=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YR/GZ3/gTSCaIKPX7lSqDWpP7xiHeaEJZC/Adz3FcvSzJ+4Nlmmoqzua5F5vXx28Ibj860pOabF/3/9oFifjg3KqM0D5hRt8L/QcrXzHQM+Wx1MwvHTzpUfOsO3PmYWA5SjC0UaugGMrbCKqfivV3tqImprgKvnNcyhCYLEP3Rw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=nrQt6cxC; arc=pass smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="nrQt6cxC"
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-50fb18c55beso30005071cf.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 23 Apr 2026 00:34:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776929665; cv=none;
        d=google.com; s=arc-20240605;
        b=dvGi1Dw1x+zEaPUHQd59vegeZT9QMRlOpfFEl9qqqTxiauq3L9D+fmfz8IvzhxXPbL
         ChxVvF1WUxlWG8d/O0jH2uiy3wlpRlslULE189ty9F0WdhHV7tBxqdunw7bKhf/rqIkP
         YBEOOW7m3wdYshTrEwakjlX4JOFhhUiqynHmKDroP2J0EwbNJTmcIKglsIxA+CUq2AgY
         0jUl2ITGMBZVgm2fK7+OGU7wxyinw8z4zUiOCyijGArybcWZ5nOyhq52w+bGrYzd8/c3
         NsKW7Kflmzhxu+6weMWwIaQ6N20eKMKqMQFIqXYfsJ1O0lSnUHH7IVCgE8xIiTkpHzjz
         dwrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=1Mdag09ds3b6m8n8Esri8WFKUeSOK/IyFAN6EmWBJ60=;
        fh=fXDaFadk9q35dnhdT+ymz+kPZkwtLeCIir9GcUcTENM=;
        b=dmeF44MgS7ypuBUZ4YxjDtpiGDa34UvJmOelDdQ35ZvxMnmvMARSqbhj+MUP/VpusG
         WmCo9F12gRG++ih/dxrvLmnBRHULY5IMj63VxugzBHWzY/PfKKe+HysH0RpjvqbwFXWa
         LnG1bWQlQxPyq1WzhZSxubqAl+ro29g/N8vraVOUICuPCYt1sGgVILHQv56Ml+8ODvhz
         CHXWpJPUZaFUSnKKhciGb2x44ddCj5IS03mQlYm8wpSjyZMjwuzoN0L8sWl3MbEtOeR0
         kPPAg5HWQWfpJDdUSjgg19Gypub5HmDJjwvt9fZ7IoJozONuELAjY7xRH1UTnmk3HYtL
         uz0A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1776929665; x=1777534465; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=1Mdag09ds3b6m8n8Esri8WFKUeSOK/IyFAN6EmWBJ60=;
        b=nrQt6cxC7S9yv/wWtSoOWNFkHBu2IzEDy/xrO0lp1ueQYpFiNqAiwte1D3xNa9liue
         20/Svi+Mfi4QD52xeBRLJhh0p1caVo97wql6C8O24ImwQNsAWrTHDquysrU3/shd8ppw
         ImTR8A7m6V+vd6pxdFtucwfyLaLjPzpYmuT9w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776929665; x=1777534465;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1Mdag09ds3b6m8n8Esri8WFKUeSOK/IyFAN6EmWBJ60=;
        b=soqITM41wdRzHqVP7ymB5qMhabjnFXxrKUaNe3c8FroXTCvJWA8aCc6P34DpGBDQuA
         oYQBlfK5aBmJLzTC5E82MIwY8qVD3eU9bHhTqEF8me3zxHoeowaxldwJSWgrq4HtQww+
         YVNwL9T16uEMPwJAHAPT9DwxhmDHfsDAomEsMbzwusPsa5vPbqJb2U6Tzn6wYRndZqT8
         LvvQo9kfU/Ligc2WqGvXVVqnM0FfV8ejmvxA6xs6HVZzBFmcV36R6Ry+7JnPg67AjQAl
         qYpJ77G/D+Z2VSEakiVv75l62YoWfaL0I+AkvmINoBBk0yAeNEL6gUYRP1gQ8ukPQjRK
         DUcg==
X-Forwarded-Encrypted: i=1; AFNElJ/lunaCvVxOYQwre/ju2zhiNstk+pEC0gVS7I40HBk6fT4xEOT3fFpadhL/KVcE4P6M7YixEruVIaPEdVUt@vger.kernel.org
X-Gm-Message-State: AOJu0YysT4wLxUzoDw4ri5MEd81INfYAj+R8NnmiFRoF07Hot22OA5lo
	Q2sTW9Jc8TdI7w6FWuXK0ESreiihsqx5pDifegy1F8eA6DxoDk/0Axck/t8sxjDQiL8A1huIs3g
	WBzbpnfQuItt/m+pzJA3M5YvhfFNGtlnyIObGMXAK+Q==
X-Gm-Gg: AeBDieu7ipZ03opDrZtbQfKrIWOMhq7y0yz2YWIgKkRAm/zk7gpMeV7CeoSmeY2iszc
	IVmlPO6V1iNnstJNiDbWNdIdpKXZkF1BSVWenrDgzUeIhooaQn1UdBDIzQQgw9NcbgdUsYG6JvS
	t7lAgtfRP75iUOxT/HEAYJyvauAxFuIjQKndWa0b6fBn7oodON9PlIEj095RnZmhOf2ZNw2bbm1
	xPcnW6D26w/qEVwaSTljqmoN17yOx98swpAFxAvTPdWB5VNhJbQXPypKqFu0RHN69mkQZna3DKU
	5sFMoyLgx1yU51io5iDOMMzY1726Eari6ptRBgzlnht5Gi5Pf6FBux/1PbY9Lg==
X-Received: by 2002:a05:622a:4d47:b0:50b:a9d3:2e20 with SMTP id
 d75a77b69052e-50e36c65b22mr396694591cf.49.1776929665234; Thu, 23 Apr 2026
 00:34:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260422063538.GD7739@frogsfrogsfrogs>
In-Reply-To: <20260422063538.GD7739@frogsfrogsfrogs>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Thu, 23 Apr 2026 09:34:13 +0200
X-Gm-Features: AQROBzAj-dP4cnh59AvC7VXEa1eR4-AhQ2_luMlBZWC_UTBYQn8qFjNPi8iBPPw
Message-ID: <CAJfpegtmXd51z0A4qAe=VSwXW2d-ds+NzBDfJcyr_p9MK-_a5A@mail.gmail.com>
Subject: Re: libfuse accepts subtypes with slashes in them??
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: fuse-devel <fuse-devel@lists.linux.dev>, 
	linux-fsdevel <linux-fsdevel@vger.kernel.org>, Bernd Schubert <bernd@bsbernd.com>
Content-Type: text/plain; charset="UTF-8"

On Wed, 22 Apr 2026 at 08:35, Darrick J. Wong <djwong@kernel.org> wrote:
>
> Hey everyone,
>
> So today I noticed that this happens on Debian 13:
>
> $ mount -t fuse./bin/ls /root/ /etc/shadow
> ls: cannot access 'rw,dev,suid': No such file or directory
> -rw-r----- 1 root 1345 Nov 18 10:38 /etc/shadow
>
> ls: cannot open directory '/root': Permission denied
>
> Uh... is that intentional?  It looks as though mount does:
>
> execve("/sbin/mount.fuse", ["/sbin/mount.fuse", "/root", "/etc/shadow", "-o", "rw", "-t", "fuse./bin/ls"]...)
>
> and then mount.fuse just trims off everything after the "fuse." and
> does:
>
> execve("/bin/sh", ["/bin/sh", "-c", "'/bin/ls' '/root' '/etc/shadow' '-o' 'rw,dev,suid'"]...)
>
> with the odd output that you see above.  Is that supposed to happen?
> Or should libfuse reject subtypes with path separators?

Probably should have done that.  But now this is probably abused and
would cause breakage if changed.

Thanks,
Miklos
