Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F011334C1C
	for <linux-fsdevel@vger.kernel.org>; Fri, 17 Jul 2026 09:27:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784280448; cv=none; b=nW+Q/rbJPxGym2zogl+vBED9kaOaf8H/NBzfKLMKHVlUCgnbR5UB9sGXkJVxC+P/9S7cd2AFR0Y7f2JYzdjeN4458GoDmGZLZSLnZtPTmH3u7CFUSJvGt3EBG+yZoXkX1ZQTmB8LuIHVW/gKYL070tohDJAHhrEIf8P63p+lSRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784280448; c=relaxed/simple;
	bh=nQ7A0qnqnEEMoVqDVr4eFiEA6xwF0n6YaMnHCQfNK3o=;
	h=From:In-Reply-To:References:To:Cc:Subject:MIME-Version:
	 Content-Type:Date:Message-ID; b=QZ5uNzb6a8F8GmsnX7gXdN09mLjEfmJHJgkRT5Z/8oQsWA1whHBRaLc7DApfQhBGU387TzcWFzy2cQhca8dtKm3Vq7oAYFmFgI2e1DStgIxbzFaRBurQuVoNzFRfjkQDSBicSGMo1GxIG/qTk+r+Qaxzgro6GH0Tg7tbQcYWAOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MCeQZl9m; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MCeQZl9m"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1784280446;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=j2ohRF12baSBn/pM1LHJIdPp9zYWwkw7DqwenEX+bKc=;
	b=MCeQZl9m4J/HJldNE+u5gTPyb5bjjABX8P0wpQQfLGJuts4k4ZKYBMRtv1P2ia6PMfOL5X
	nWIxM0qZIDFNMsNSv5Szlu/J0HtuYcdjqwtaDXLJlhiYpf+8LGo+Y2Tdn9JO2vClSGq2TK
	9CubJl0a39yTfrXEJrvYgQxeALhKS8g=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-226-0-v8TEHPPFeCOQNSxAUgFw-1; Fri,
 17 Jul 2026 05:27:22 -0400
X-MC-Unique: 0-v8TEHPPFeCOQNSxAUgFw-1
X-Mimecast-MFC-AGG-ID: 0-v8TEHPPFeCOQNSxAUgFw_1784280440
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 811AD1800750;
	Fri, 17 Jul 2026 09:27:20 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.44.33.159])
	by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id EA72AD72;
	Fri, 17 Jul 2026 09:27:17 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <20260706030439.14212-1-xiang@kernel.org>
References: <20260706030439.14212-1-xiang@kernel.org>
To: Gao Xiang <xiang@kernel.org>
Cc: dhowells@redhat.com, Paulo Alcantara <pc@manguebit.org>,
    Christian Brauner <brauner@kernel.org>, linux-kernel@vger.kernel.org,
    netfs@lists.linux.dev, linux-fsdevel@vger.kernel.org,
    Jingbo Xu <jefflexu@linux.alibaba.com>
Subject: Re: [PATCH] cachefiles,netfs: sunset ondemand mode
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <3594658.1784280434.1@warthog.procyon.org.uk>
Date: Fri, 17 Jul 2026 10:27:14 +0100
Message-ID: <3594659.1784280434@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95

There are a number of mostly minor issues with this patch, as can be found
listed here by Sashiko:

	https://sashiko.dev/#/patchset/20260716103030.3065561-1-dhowells%40redhat.com

I've fixed them up in my tree and they'll appear in v7 of my "netfs: Keep
track of folios in a segmented bio_vec[] chain" patches.

David

