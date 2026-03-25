Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4C243C455F
	for <linux-fsdevel@vger.kernel.org>; Wed, 25 Mar 2026 12:03:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774440229; cv=none; b=EyV/c+BwsH+KA6AaBPwViB+NJP5qypkC2GFp8B+BpBpKH4GVpUwm0dRC6CZLIemJGwz0YvNa3kWJ7zE8syopj4oGVV6j8mH2tLzVnRrQUIMGZVGnV56fefBxE3xKYMyIcM9LG9FFvxV1nbnDt8fou9bEzguiZXA539+zSzbXDzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774440229; c=relaxed/simple;
	bh=Es77No52KNJFPGo5T/ww8er3pjI2J58fF+DFC1d5WKg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tpcByFn73xDoWz9EG+lRJY96go+0ibgPRFq0aa7073sF3Zq2A2CucQz0rxDCgRHkF2QjYEjdOhJ6z7JwNqXK9JwylxNlqiSsPhJmX9itMWPTdZjbQahhy3VALQboZIsVw1PzKucSwlJHoBoAolwyTDJEvhZd0ipUBSCJ6CkuzkU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=icsZpUJg; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=UPY85kNK; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="icsZpUJg";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="UPY85kNK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1774440227;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=hHtDuEkZI5nETEV2K61pi5NwMLau14IczzFE7YDeBkk=;
	b=icsZpUJgksX5aS21xOoEsrXLJPEQ0IWt3+qFA33JkWHh3XSvL3vtrMGW/8Be3vMFl5m7Lq
	Pa37XKpl8XMnNpOld39exKbAeI/2uQV4OO3YREMx4eTA2Jo0Elp7xRH9hpDBcxGugV8hed
	q8sObHA0rBH20Hjam6wOZoiNcRfjJrs=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-668-hCKGUvLuMueFeqbxC5pNEw-1; Wed, 25 Mar 2026 08:03:45 -0400
X-MC-Unique: hCKGUvLuMueFeqbxC5pNEw-1
X-Mimecast-MFC-AGG-ID: hCKGUvLuMueFeqbxC5pNEw_1774440225
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-b97d773ea61so197834066b.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 25 Mar 2026 05:03:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1774440224; x=1775045024; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=hHtDuEkZI5nETEV2K61pi5NwMLau14IczzFE7YDeBkk=;
        b=UPY85kNKISxwUNJaz9fXarSB972DdMWQEnPwXztyKjQ1HH0D4sH480T4KKq+SRtwqw
         qoDk5VVHoj8UJRdfYHT+TSAGYmwpXcqixbOJ5DZ1+ZEXPYuB/1f98YTobC54Tii++3jy
         HxCfodC7sj6qShUYp+Kq1WE0MrlY86OVZ3ykJVqmh/RW3xSNrZULAimQeTWEUr9A0zSH
         JHeE7mJyO+Gw7nIQrr7Ar1lVXExGDPj+gGjrUFzx39Poi+yGoB+RrKKrNK4ASwlVc/I7
         smzeTJT8Z53psmWcQz1HHHHwTezoKmWuuKl9FgjZy3Y8+Jgvyd9JgxG7XpBA20gSRe3f
         QW/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774440224; x=1775045024;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hHtDuEkZI5nETEV2K61pi5NwMLau14IczzFE7YDeBkk=;
        b=OBajM76BuqJeLTfXhtEsJ8HZ4tc2yTrdOxSec1bk6miOPqLQkuNtps6xmFaY4LRVWc
         9quoTXLd5QpP9IEr2wi91wSJS/vC7t0xKAewCpE1h94VkoNrtAYaAXH01TW2tVqmB+Dk
         H6MBKBMR2Wy91pTY0Ekwb2YbKlXbEXmzNWSlaH+KC481Vt3kxjhNv9ncZC9AkXb8l5Ji
         +OPnz4q2pM1GKQBZARMhkW6BYSSGFkuxf1jOsPADQzsPjxRRj0HbrraHd4TJ4QLeAA6A
         +uNwGsBCHVjBVVKQP9uMgXnY1Bn+pjd2qoy0khM1A0WbW3T22oXeMyX7RjtZeXI4OADo
         SzbA==
X-Forwarded-Encrypted: i=1; AJvYcCXhSDMc9xjrSGZdRGLP83mgyIycJl5+6T6cw3SpYa5jv2rSGlgnpJN99fe+qgPy+/xFh4tB7bM0/lxgR+ex@vger.kernel.org
X-Gm-Message-State: AOJu0YzBWcF3nFNsEmuwdBS056e2PI6PlpNauj6sPBmsyb/kWofYXi36
	huJOr9BvYqSKBLx08SAQFryUSnrZ+6b1WQ+5vR4k70j1rc5zrqgsaQN5SKqrruReYWx5Ri+q7Bi
	uGCKkgNzswaXlRUNut2+fbXz6OSmolc7vVG0B2BP75CI0ufxxD9E2DR8bqLb8xWq1tqcNccPOFs
	G/
X-Gm-Gg: ATEYQzyUIdjSSes3+r6nu/KkQdEGrYyzmQ8uHtIMESgkRij4YEL1VF9mO7pwzfv1LrT
	ZSDBEgQknthj4TPXepqZlQBw5hbDuu/Qu4lQbjo3tSLEbGhGfXZk2EJqflBjtGg1PhTWgNiGmPa
	2dlqDm/KXtpjn3p/xgVCUO0B+iXtUO+8Y9g6NGGjzUtmaatJRr4QoAEZQmWSr3xXjPFSq+sLkW2
	HG8ofZBuykkfBav0ct4msExNIfkXRhnxgqlZ9Lp4VKKwcRc62aqtOJ/MNVpoSg/8R24AD1CEG1C
	jTzBEjpg2GZtTUPm4FtVBDpfYX4XPZI+IHhzWpctdynd+4lf5sGDV8nWxyDR1YRaMxi8em8zZR+
	OhbXSj7yL4dBfCg==
X-Received: by 2002:a17:907:3ea5:b0:b96:ff4f:11ea with SMTP id a640c23a62f3a-b9a542834b3mr225196466b.41.1774440224230;
        Wed, 25 Mar 2026 05:03:44 -0700 (PDT)
X-Received: by 2002:a17:907:3ea5:b0:b96:ff4f:11ea with SMTP id a640c23a62f3a-b9a542834b3mr225190866b.41.1774440223277;
        Wed, 25 Mar 2026 05:03:43 -0700 (PDT)
Received: from thinky ([91.245.205.131])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b983365a159sm760453666b.44.2026.03.25.05.03.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Mar 2026 05:03:42 -0700 (PDT)
Date: Wed, 25 Mar 2026 13:03:40 +0100
From: Andrey Albershteyn <aalbersh@redhat.com>
To: Christoph Hellwig <hch@lst.de>
Cc: Andrey Albershteyn <aalbersh@kernel.org>, linux-xfs@vger.kernel.org, 
	fsverity@lists.linux.dev, linux-fsdevel@vger.kernel.org, ebiggers@kernel.org, 
	linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net, 
	linux-btrfs@vger.kernel.org, djwong@kernel.org
Subject: Re: [PATCH v5 03/25] fsverity: generate and store zero-block hash
Message-ID: <vatqzcvepp7z6iotzayuyh7fajwdqs76pn4o3sdn3f5thiwsjc@dt46ylrbjnkp>
References: <20260319170231.1455553-1-aalbersh@kernel.org>
 <20260319170231.1455553-4-aalbersh@kernel.org>
 <20260325075700.GC952@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260325075700.GC952@lst.de>

On 2026-03-25 08:57:00, Christoph Hellwig wrote:
> Shouldn't we still try to get this out of the fsverity_info first?

I don't really understand why, this hash depends on salt (inode
specific) and merkle tree block size (also inode specific).

-- 
- Andrey

