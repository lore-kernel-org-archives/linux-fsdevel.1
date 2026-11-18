Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795019433;
	b=azMumD+ImH4VzKowcqDXnaPkKB2OiYNZrdXYzi5X+dzIaRtuVQZ/Ayvnu/SdzN+i2GXQ
	 vTFZ0RJyd7BVPBqTwnCuifx+vvTfN3eOK1DGU6xnf7zwZVdIoS/8NVIPHZO1R5fLd6DDk
	 XSmJKMHNS3VRc8CSOJ36URTqcLOwZAZ4Kk/D+AtJaOgzUyxRK3jklX55j9c4azsTwgHh+
	 jM0cAwFTyYi9M3WfmjTgJdQ8T+yFT12lk2DnRe1wLUI+3gdB3M5Bf1VtAl4PUV2pOhH4Y
	 6CMTbbBUWRHa7YlLsd8F0Ogy5GydVGiCSpSHspPQHtiWroBTYxIbq5ic9b7RVERtnfQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795019433;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-Scanned-By;
	bh=r6qnE+rrPP/+WIwyrf6W7iyVRQaaxGpUn+33m8pv7AQ=;
	b=lBb4t0XGwC0FYUMyMgMkxT6uoTj8Un/4hny7gujShfMnlNzPc7Gnp+MjVaVE4vuZanvk
	 HXDyoiqLvid8X/Hgbk3zKHWnHRUkWb/JKE9qbHNIo/KUT+jBPtVbQ6zbVfEhgDuy1ntLg
	 r2nzcjyKKSeCLgmiI9t6O9FxFJSJmoVW58Bb/Q3E4YTFrcl+0z1F/LTFgBXxpsRsdtWiC
	 JWUB3A8tOcJYbjohXp7bk6rBtZmv1bfQZqtClKoM6p1fgJ519oheUgZI49WIpmW32WG51
	 SmpfJQRuubrIQrk7v9nOzqZhjU/fJM6aQso/WjZ2k52pXq8qufrGUI58y9qRljIXRsA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=QPPgpJDZ;
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B16F60A6F54
	for <linux-fsdevel@vger.kernel.org>; Wed, 18 Nov 2026 16:30:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4B16F60A6F54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=QPPgpJDZ
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1795019431;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=r6qnE+rrPP/+WIwyrf6W7iyVRQaaxGpUn+33m8pv7AQ=;
	b=QPPgpJDZRE3zOshdM3p3v7D8Gsr3aenDis/S8wp00dl9zNOiDphGAbzYbUPIlzk0xzjJmg
	NuXTiRJQOiWrZ4aoAuDf9gfRSQoSkmsaoK7DxyxPoZsRgCmYW6cnV7Lr5S4FHkXGPeJqF9
	bDkX9uGQteAi7EOWUtXf+7riYeeDU7o=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-144-ykpJEus6P_-OoU9HyaJLdg-1; Wed,
 18 Nov 2026 11:30:25 -0500
X-MC-Unique: ykpJEus6P_-OoU9HyaJLdg-1
X-Mimecast-MFC-AGG-ID: ykpJEus6P_-OoU9HyaJLdg_1795019423
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 39B6F1800365;
	Wed, 18 Nov 2026 16:30:22 +0000 (UTC)
Received: from onestero-thinkpadp1gen7.tpbc.csb (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id D9A5930000E8;
	Wed, 18 Nov 2026 16:30:18 +0000 (UTC)
Received: by onestero-thinkpadp1gen7.tpbc.csb (nbSMTP-1.00) for uid 13628
	oleg@redhat.com; Wed, 18 Nov 2026 17:30:21 +0100 (CET)
Date: Wed, 18 Nov 2026 17:30:17 +0100
From: Oleg Nesterov <oleg@redhat.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Mani Tofigh via B4 Relay <devnull+mt4022.columbia.edu@kernel.org>,
	Breno Leitao <leitao@debian.org>,
	Christian Brauner <brauner@kernel.org>,
	Mateusz Guzik <mjguzik@gmail.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	tz2294@columbia.edu, stable@vger.kernel.org,
	Mani Tofigh <mt4022@columbia.edu>
Subject: Re: [PATCH] pipe: keep per-write wakeups for EPOLLEXCLUSIVE consumers
Message-ID: <av3SmRMGDLVAwMzK@redhat.com>
References: <20261111-pipe-epollexclusive-wakeup-v1-1-0af6283e9fda@columbia.edu>
 <avxWKI795DthE8Sb@redhat.com>
 <CAHk-=wjOq+G=6gte4vX_YxOD_VfE1uZh7=+KHs8N0wU75xyHEg@mail.gmail.com>
 <avyODoFhZ_M7YDU5@redhat.com>
 <CAHk-=wgcBSBtHE+3ceKGjq1jyF64OyoEqf5JPpixowAa80GqNQ@mail.gmail.com>
 <avyVwg-5ef-pXZkG@redhat.com>
 <CAHk-=wjJF8uZLfVbbqei9-fhs9K70i2OnVreCV-rQF9EGKAxJg@mail.gmail.com>
 <CAHk-=wjqParwoB8wb9KfGVpbwUwvKvObpLOo=XPM0GGfkn3ibw@mail.gmail.com>
 <av2juQijIISJAgyf@redhat.com>
 <CAHk-=wg4RgBYZcUU+c16XxdZ4UbAaazJkUS=R6=tpN4xUBdDRw@mail.gmail.com>
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wg4RgBYZcUU+c16XxdZ4UbAaazJkUS=R6=tpN4xUBdDRw@mail.gmail.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

On 11/18, Linus Torvalds wrote:
>
> Some duplication - with explicit naming of the locking status for the
> special cases that are called with the lock already held - is much
> preferable to dynamically doing the locking

OK, this was my plan B ;) I'll try to make a patch this week.

Oleg.

