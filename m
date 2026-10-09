Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4E8D4E5329
	for <linux-fsdevel@vger.kernel.org>; Fri,  9 Oct 2026 14:50:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791557421; cv=none; b=QrDDs3r9RL3ToHWjunqnI8y6szadeCJrDQOsDGgPqrutom3rOv8SNGQ7zn71Ycf0V2UMkNxcSq2rSTPXZvSRpV1X9bOzmCcMyqOg7fjYDAPr50NSMeNRS1J9QsaC5JuxFi2V1G5IT18WQ3nWg42L5uoahlCJzZPWCeKzhMuBhj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791557421; c=relaxed/simple;
	bh=QMBBcDwgjsDjyl3EBe3JFAp/DeQlExENh9tN3Jkup4Y=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=bf0o0oj+cqu46RjBFSQPzdgX5u0qZbcUNHQW+6iE9OY8ogMYKg4acGiQYtDQ7JI+zG8O45iAKl++nEecyylmDibOXywZn+RV+OqFQ0Bxjytg07t79em7xisfXV39lu3t/LcgtJ3KvNNDAOjs73zUkW1il4LIfMP80uWkbiSGxNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=enBGoHc9; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=KpBa0oqT; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="enBGoHc9";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="KpBa0oqT"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1791557417;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=denjLYVgwbF9iEIwmMqmhaeRtlsrnClW1EGbNR+b3NA=;
	b=enBGoHc9RMNkxCvRD2c8TYF3/4Qa6itjGVdPONhLMwJbDaQRYwUaHpqdM2Bor0ts5JBugZ
	83aRRGaXgGHJfxLZrXjX9tzkPJY9JjcHm2LrTJL3ewRtkeg+uAwdmLJY7LwQQFfjkuhtSg
	8+2gkR0jtI7uLXPKLuWnnz8bg4qzoOI=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-436-A7KiF4JeO-GT5KyjcBIfHg-1; Fri, 9 Oct 2026 14:50:16 +0000
X-MC-Unique: A7KiF4JeO-GT5KyjcBIfHg-1
X-Mimecast-MFC-AGG-ID: A7KiF4JeO-GT5KyjcBIfHg_1791557416
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-917a109c937so85772076d6.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 09 Oct 2026 07:50:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1791557416; x=1792162216; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=denjLYVgwbF9iEIwmMqmhaeRtlsrnClW1EGbNR+b3NA=;
        b=KpBa0oqTj9m5sD41mCfx7jGDTOnLdHFeZUPB67cJE+y/DXq5ITUrYNE2jmaIzF2sAS
         yn47mDu9Scz+ie+NxBLJ7INu2cefHnqmJ8uhblfw1GnT6zke16lQ0RA2qj0st6zY96Mi
         8RVokFXlBz0vU6x5KUvj4UVBtLyHebY3TvE2dH37638/HZyeb3DFgV2MsxQkc7Ag15KX
         vptR0DP2JMZ6ocV7Nq8R1pdlyy5goDIFUinfqmMeWF8Ze1RQ6vYSiZyDKKqy62/XzCKz
         LbBFBEHo+E2N34l6FqYzZZ1tpEr5hmUlrnFFOPJLNvUKl+T4mkV6HozQ9+q3gFjjLHo5
         Wmkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791557416; x=1792162216;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=denjLYVgwbF9iEIwmMqmhaeRtlsrnClW1EGbNR+b3NA=;
        b=cXD3MsTVfjSUn9JtFuh7n+vBDSYHDskWs1unPGOH7hks4GYoIcXXPgfHyF49/reIJb
         89ToJlrJNe95ahaAgH/8jM/s9SHzC4wJcKNcNU0p2E4uD76Md86or8vPuGpJYhuhbBrJ
         FgiCwcl1ky+Jp3Xwsb2UBcfkYZyFUh+WNkLHSS3jdwAGQ3pXXc25T7/auFRN7B8Xxu5B
         Gx8Ylh6qaNU+ZohsD+NVB4+pKDj7jl5gfmNwyseRdpZliRA/JMC888pN5QBhFPCNwdq0
         XoJPfGKFaQNaVLWQgfAyS7yYhH8W6bl7D1OxtDGowSpHQSSLyJNG7ZlUYe0GB2ZaBJhe
         Nm4w==
X-Forwarded-Encrypted: i=1; AKwUvBxdnLpddX/tMJy+Uk0qWcDu5b/ySMOD7quBst23AMsTK6tqS96ru9N/lSjOWd2guAk5D1BGhXFbm7HXD0Su@vger.kernel.org
X-Gm-Message-State: AFq9FYJ21cdNYJSw/X5h1H4Uae5l/5rKLufwnI64jAmLdYnedCBrERjp
	IEWiFp35Exi1x7RzR+32qvk87CgSE9WgsSMTS4yLagoJfK5jfWrdeuAtazPG0FiZIEvmm9AXnoY
	k7PZO3wqG9V3bx0PrGW6Gbo1cIPnBhprxtC3J5knG4KqSZrXrO4LQ7A7NcOhIaJKbhVcAPZQgmb
	41+w==
X-Gm-Gg: AYBFou0GGXZ8p5TXh/4iZsMZ7bmJFjExoCehFi+91ItOVSAyEoNL0WscD2xWt8LzJjO
	aUctJQ9ThufJPMEU97l+ydF9oxLWGTqbw/UIrEQbBNeU7jqcqGozRna9acOd5OVYKIN11mfTIkN
	wVw1d3Qv9/IYe3F4qEKQ1ptQObK1Dti62btDdIfuRPna2qOvADY7EmzjiomIsCi4d4EC9XYGX27
	Wy4wcqilb2lKo+1RziW99j1EjPFr7TZl5DV8YGoajjabaM43b2yJ+sgGmDs10ASyBLnz9iDw3O4
	KrEe/dIaPUMLa74bD8j98tgXN4iUkJthq+hXRSNjivil1ol+weVK8SGbJr15wpMaw2zTZlKlOXp
	S65I21v+5tukEHcIBPxMHgVo/9SjQnsGrZZvXWHz3/FEYDVTSHQZvxTCxKF325H894h3LDbhz9w
	J5SXklPJLiXmIQ2w==
X-Received: by 2002:ad4:5def:0:b0:91b:53e5:9263 with SMTP id 6a1803df08f44-91b55531337mr36208436d6.21.1791557415679;
        Fri, 09 Oct 2026 07:50:15 -0700 (PDT)
X-Received: by 2002:ad4:5def:0:b0:91b:53e5:9263 with SMTP id 6a1803df08f44-91b55531337mr36207516d6.21.1791557414875;
        Fri, 09 Oct 2026 07:50:14 -0700 (PDT)
Received: from cluster.. (4f.55.790d.ip4.static.sl-reverse.com. [13.121.85.79])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91b550dfb6csm20185456d6.45.2026.10.09.07.50.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Oct 2026 07:50:14 -0700 (PDT)
From: Alex Markuze <amarkuze@redhat.com>
To: David Howells <dhowells@redhat.com>
Cc: Christian Brauner <brauner@kernel.org>,
	Marc Dionne <marc.dionne@auristor.com>,
	Ilya Dryomov <idryomov@gmail.com>,
	Viacheslav Dubeyko <slava@dubeyko.com>,
	Paulo Alcantara <pc@manguebit.org>,
	Matthew Wilcox <willy@infradead.org>,
	v9fs@lists.linux.dev,
	linux-afs@lists.infradead.org,
	ceph-devel@vger.kernel.org,
	linux-cifs@vger.kernel.org,
	netfs@lists.linux.dev,
	linux-fsdevel@vger.kernel.org
Subject: Re: [v3] fscache, cachefiles: Fix resize handling
Date: Fri,  9 Oct 2026 14:50:10 +0000
Message-Id: <20261009145010.2380147-1-amarkuze@redhat.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <1091807.1791483394@warthog.procyon.org.uk>
References: <1091807.1791483394@warthog.procyon.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi David,

Reviewed this on your netfs-next-5 tree. The resize helper it changes is not in our testing branch.

For Ceph this is the right split. ceph_fill_file_size() stores the new i_size before __ceph_do_pending_vmtruncate() trims the page cache and the cookie, so the worker can no longer see that the file shrank. i_truncate_shrank records size < isize at the truncate_seq bump. Without that, a truncate that is still above the stale cache size takes the grow path and leaves the backing tail in place.

IMHO the same flag is right for the other filesystems. AFS, 9p, and cifs_resize_file_locked() still have the old size at the call, so shrank is a direct comparison. The grow paths pass false, collapse passes true, and cachefiles shortens only when the caller says the file shrank and the backing file is actually larger.

Reviewed-by: Alex Markuze <amarkuze@redhat.com>

-- 
Alex Markuze

