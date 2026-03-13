Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33FE53932E9
	for <linux-fsdevel@vger.kernel.org>; Fri, 13 Mar 2026 12:34:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773405246; cv=none; b=GEHXjCKlCA2lkL7IJGBzbqU9vqj02SW+qpc8NNdgOKaw263T/57cY0NPiCfKqlFz4DXqCqH10G61ac1cywMHQor0jEuurmhSKmTebqvnHb/gn7eXHMQrgaaSWYRizLaZH+XfL/zsgLlCTompVAallhbkdngeutXuFSBC7w+8G6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773405246; c=relaxed/simple;
	bh=0+jmGfASOQpL5pqp2GBWNab5/cK7ZIFZVpy9YoKuICs=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:Content-Type; b=BJzQCo+1befH6zB8wsnjO2FWPzzenLDOgH6CuhQ/GNWwxE/NekTy2bl//GHBo0yVe4ehyQ2og4kYwd+F/G78gj6TGXgoa91eEBv092FPPl8loNFB1Q4CSaWde9sJRzN/q7qe6t46qca0M2m3CRVwfTRquim3TVNU8x3jwkH9kLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=aPmL0bZS; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=OYfQBY8V; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aPmL0bZS";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="OYfQBY8V"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1773405244;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=9obGIpUR/NoWbwOoT3DbWmrgxAhcjPxe9q4vNT8R/gY=;
	b=aPmL0bZS5XOERDM+HCfstrvbFN87YK3PJa23XGwClfpq223LBigzF+UrN5MRfmKO566ALY
	gQwefnc23Q4GMJGDcFJLjHycsK9soZOB21F7UVvWrc4Zba+gbZlrZfrQSGWiI/cd7FEdUa
	skBvDuewVp65g1AkYfaoo1VkmldXUkM=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-333-luC1o_uaNV67c5RMC_kLEA-1; Fri, 13 Mar 2026 08:34:03 -0400
X-MC-Unique: luC1o_uaNV67c5RMC_kLEA-1
X-Mimecast-MFC-AGG-ID: luC1o_uaNV67c5RMC_kLEA_1773405243
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-8cd8b37d4b2so1570849085a.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 13 Mar 2026 05:34:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1773405240; x=1774010040; darn=vger.kernel.org;
        h=content-transfer-encoding:content-language:cc:to:subject:from
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9obGIpUR/NoWbwOoT3DbWmrgxAhcjPxe9q4vNT8R/gY=;
        b=OYfQBY8VkhouVaKsOMiysi4v+c7UDmvP3W7OeeJaY+bS0OK/bW3wR4vtEpeTjj1wDz
         TA6j67mjeIEqE2U2TUkWnOSwisml700HtQaD1zyNRIKQwk/jc2hpehrLWDuW29SM2WlY
         NBXdoObaGfWmLH7/FdenAmC/biY7hMD2wB+IzOMEPihukDunXkzsMcHzL8zYWe7IwT04
         hZT9eGYfzZRHHJpi+T9X0F+8IOWHfP716RiXsbaRJKwu4k1cDghZwMd60dhAxdYtYJ57
         z5RDYNqRBvklm48ryEdub0ZZDQeUgdNyucwAye2OfS4vm2lk57oc+3gvaQ1tTC3OWAGu
         2iWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773405240; x=1774010040;
        h=content-transfer-encoding:content-language:cc:to:subject:from
         :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9obGIpUR/NoWbwOoT3DbWmrgxAhcjPxe9q4vNT8R/gY=;
        b=k1Zv655L0DZA1wDgLzs6gMKALj0y1M9mPtFdv25L6HY1X3qbF4OEu8PnVjMKgz73lU
         Gu7GBkw/Ir26QBGxsR6RQO2IolS7QXCly3fslmVgVB00myOg53QCyZa7QRT/NSnVJQH/
         yBQcj6ZqCvmNG54gz2H/1xCEDj9ZxieYbfF8x1NXOjKTqcUzPNyOc8jbNtHP95gZYfjv
         tF1ZKlZXXGFa8JAGIdFMLTUsjQTtxWpjXkqdMnxuZ2QmydYIoXuyjmRu66YrONb21wUd
         0qzL8dkAL+Dpp6vOV9o+hqWL+1EtKrsvvlco9Q7lIyiEjgQynhBc2uR3GLhaGNnQmSrU
         S/4A==
X-Gm-Message-State: AOJu0YwbbwgoJnmpIDv/BJdDh0jTFV1Xu7qu1L9iZTm7f5h/1l0OALW8
	NRVeGhLd6dgL92FvPtHIXGhIz+GVA9fTnurJJAms61Ozv4KzeXWpeA9pshREAtigASKt7bPG8xl
	E0yLq4B4d3GjJSE00xfKpki3rjFvkHYgVrJDzDujso2ikjZ2T24hmo58p+vsRHnEMLKFIE2dCOd
	k=
X-Gm-Gg: ATEYQzxRlfXuoWTZ6EmpTYbi9aoe7pOudUyfkauJQ1J37IDV+QzjUAKY1qblq1V5mq6
	ui7Y3NJCb88Qjwbhwz7PKBI9hjXdl6QtpoZotHHf+5jp8WOtYKUmGSGkX6BYtpZ3DjMcI6DquX8
	RSMiicRKmnmlK2oDxMimPf3cr9hGLyolg1DaNP2072p7U3zvc7fuujEtxM4vTe2YFfpf2OHvHSS
	XG53dld/WoDnXRtB7oLkG9fX6garHzh5Za3O3715UMYo3FelVOyWhfmNCe8yfH7BrvPt6mPhGgH
	geJ8P/58uSJb/oBAz9SOtdje8lN6a/E8u1IIFwhA3IfM/SCFNykF4YTBto61PqOybcHFesjFk5p
	udvCzJxAgA5W9hHRChmjrHA==
X-Received: by 2002:a05:620a:690d:b0:8cd:8ee7:446b with SMTP id af79cd13be357-8cdb5b3ce8fmr367909385a.55.1773405240348;
        Fri, 13 Mar 2026 05:34:00 -0700 (PDT)
X-Received: by 2002:a05:620a:690d:b0:8cd:8ee7:446b with SMTP id af79cd13be357-8cdb5b3ce8fmr367905485a.55.1773405239776;
        Fri, 13 Mar 2026 05:33:59 -0700 (PDT)
Received: from [172.31.1.12] ([70.105.248.208])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8cda1fbcd2esm588237485a.5.2026.03.13.05.33.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Mar 2026 05:33:58 -0700 (PDT)
Message-ID: <4d11b9d7-7b49-4a1e-8c26-29ecb2fefe2f@redhat.com>
Date: Fri, 13 Mar 2026 08:33:54 -0400
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Steve Dickson <steved@redhat.com>
Subject: ANNOUNCE: nfs-utils-2.8.7 released.
To: Linux NFS Mailing list <linux-nfs@vger.kernel.org>
Cc: "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hello,

This is a updated release of nfs-utils-2.8.7

     * Fixes the nfsrahead bug that was in 2.8.6.

This was a community effort of debugging and testing
this fix... Thank you all!

Also note there will be an upcoming release (2.9.1)
that will be tuning off NFSv4.0 by default on the server
which is already turned off in the client in 7.0 kernels.


The tarballs can be found in
   https://www.kernel.org/pub/linux/utils/nfs-utils/2.8.7/
or
   http://sourceforge.net/projects/nfs/files/nfs-utils/2.8.7

The change log is in
https://www.kernel.org/pub/linux/utils/nfs-utils/2.8.7/2.8.7-Changelog
or
https://sourceforge.net/projects/nfs/files/nfs-utils/2.8.7/2.8.7-Changelog

The git tree is at:
    git://linux-nfs.org/~steved/nfs-utils

Please send comments/bugs to linux-nfs@vger.kernel.org

steved.

