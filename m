Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792528028;
	b=ogUybkeGscoY+fFlcHJ9NVJN5QkBdKSPSXuBUB92BFyiAD1hugSkA14EEFZeQkaAIJxW
	 We4JbvCIavC5m89rL30xa3Lded2QqW0qvpwN5yDjig242DAoP+nVEnImFkUna+vPz4Uv3
	 OpyhSCSaiaR1doxcn//vqPtU8BkFQAmeFxmu3ymtq6xQFpo/W1atrDbPg378EBTpD+Q3P
	 IcngTwcR7R9+ynbwhe0sMeYDj2qQmALNZ9O1Gf6Tgi2sJajT2yfBdp86Zlkl/Q1MYVwzc
	 vP0LU5Yl6/vfJL+H9N7gLkg8kjg+5mnQXJiPCH+BMwa2Ap3RXDu6Gs3hPWsvwU5bOHQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792528028;
	h=DMARC-Filter:DKIM-Signature:X-MC-Rep:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-Id:X-Mailer:
	 In-Reply-To:References:MIME-Version:X-Mimecast-MFC-PROC-ID:
	 X-Mimecast-Originator:Content-Transfer-Encoding:content-type;
	bh=RRNHwuzxK2uMbz7SC9yJ7WKgsG9c53Ltjg56svJJIY8=;
	b=2RQmoegHByyKuzvDMhwibzNWc2lGh8SHueBbpt+GLva7S1NvmP+h3qRzf3gV5Txv/IuB
	 3EDIqSRCt5u718yPI5soLSUAB2ZAVtI0BIM7A4fIQZn8Mr5FFFe1VsrPiXz4GTE+uJT0M
	 Y13qhP6ssgwuANWBasf5XhD4B5m4rIlLXhJ2efFfvwGbSlexSbOqdOWqYJGtRWV0xpXFZ
	 Qm058f80yoGzeN6slGF7Uj+f99UmeeSyb08OIJRn6OWF+mA5M42Y1n1gkgGasKQpdbxH3
	 1ahGDAIlGuoOFh04hilTgkS3Z8afPu79ip1+VeuqyIKJxiUqN7LbpFaqi/E9s3dARmQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=IrDsRmxK;
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EED1C606A33F
	for <linux-fsdevel@vger.kernel.org>; Tue, 20 Oct 2026 20:27:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EED1C606A33F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=IrDsRmxK
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1792528027;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RRNHwuzxK2uMbz7SC9yJ7WKgsG9c53Ltjg56svJJIY8=;
	b=IrDsRmxKj+37PrHJdV34OzD2QWIUqltac84n2wXjqHyOM7MtJ+1MiG4QKapERCzr6On9oj
	fhQHIT5FVURhLVYv6iEHfwJqvwBqyFjG6bHhBD8Fec9oMMqAdXKmPJaYFWYsUMA9H8VXBs
	Y+BPjKK4O5lBQxPaKeT7C0nhA+20Pck=
X-MC-Rep: binary re single
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-1-Ke8Kgm1fPc2LsfDhO1LquA-1; Tue, 20 Oct 2026 16:26:59 -0400
X-MC-Unique: Ke8Kgm1fPc2LsfDhO1LquA-1
X-Mimecast-MFC-AGG-ID: Ke8Kgm1fPc2LsfDhO1LquA_1792528019
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-9195c59ac8cso2821176d6.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 20 Oct 2026 13:26:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792528019; x=1793132819;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=RRNHwuzxK2uMbz7SC9yJ7WKgsG9c53Ltjg56svJJIY8=;
        b=aQiwVpILPaeisUadSnzDrw+5r/E8K7XrDe+7ICEVPHsD7TNUYu/Q2HGOHlE5GYbm8B
         llJQ3gko8t5Wj7GjtIMS5NnbLo5ox+xhwde8slcr/v9yt8rqA4YwW61EGUdcCg0rgh1O
         JR7xhVKGYSCApOi7GxEsmlRjaxF1G3UZ4pY38lGTSbTjYfNPXdIXp3jKUOrT+OX1P18n
         iU1labWHIYpKnw0+3MyIE0lIVeVULiNLESyGk6VWVsOxerNdmhkBYP/SyaIPuMNjIvH1
         CKL3dC5Z9mX75e6HOSLElYdc6Cb+SAcyD5wYRlRTq1Hnad5YueRqlrYlonjfwjuXyhCV
         XMxQ==
X-Forwarded-Encrypted: i=1; AKwUvBxERIDaMNKpu1deuubQvJ/hB2mc8ADRriWhMh7RImTmD06IcppSLy9059EUm40ABxmQVzCJTLB9mRML2sLO@vger.kernel.org
X-Gm-Message-State: AFq9FYJiLFGRZP/EamuDJo9CYonbEJ4+ju7wNYtoQQ+iPGVkIWtv0pbh
	huPHAbOzK6mcUsgcANThFy3SRrQCbq31uEfiFhPmrK6xWCwOvYAYhucqzM4PS05gSr5UYyTZKPL
	AetxfjVykfIOfgolEGIfmIdQL8bISMxX1cbihZfRz5aB0NwvINsfiJgvbCjSRBrltdxg=
X-Gm-Gg: AYBFou2Yp7akJe+tS6VLMJUFss6PJDIJesyyidS+OAAg8pF2x39joXtck4xUYpj49Jf
	IxYNWjLALzK3+/cc6OjVm90Ia2NCgK15Oz8Ft2nUk8EDqEsnVvlwdatoxIXvt00ZPt4FPvdoULC
	2OMYfh2U6W8KQj9WajaW4I0TSEXIm1hleXRgSV6inWy2DDJ/bgGlp9sJ7Jc8PZiZZHhIQ6nvD3f
	kWyPqKbBOZmTvAUzYm/CCKqE9POXXQPNTapirw3b4TMQWObcUQAWQpV6ZA7CdH2rP5xtMfLtFmx
	mQBaL5stFA2m8/dRds0Ocykz4cnQNl1OsPtj9gJxVIF0sdpGVsZ+dhtDq6pMPFOtbYvVjgCZ+Ir
	x4wex8wnFv3y38rqW2ahcma7yVggYoVvgB1NmkJ/z1Xb4MOqjDnwXrd1VGYn7BH38uMLGrUA93W
	NXLwZaX/Rw0jNmNSUUWpJPEqM4LGpQYQHFn92nnCLPhZu6ODL9t2MVO6A+qETX2wj3fqtibOoyj
	f4=
X-Received: by 2002:a05:6214:6107:b0:91b:f9ab:3944 with SMTP id 6a1803df08f44-91c01f39390mr65133186d6.7.1792528019298;
        Tue, 20 Oct 2026 13:26:59 -0700 (PDT)
X-Received: by 2002:a05:6214:6107:b0:91b:f9ab:3944 with SMTP id 6a1803df08f44-91c01f39390mr65132696d6.7.1792528018761;
        Tue, 20 Oct 2026 13:26:58 -0700 (PDT)
Received: from cluster.. (4f.55.790d.ip4.static.sl-reverse.com. [13.121.85.79])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91c10a45336sm7461436d6.3.2026.10.20.13.26.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Oct 2026 13:26:58 -0700 (PDT)
From: Alex Markuze <amarkuze@redhat.com>
To: ceph-devel@vger.kernel.org
Cc: Alex Markuze <amarkuze@redhat.com>,
	idryomov@gmail.com,
	xiubo.li@clyso.com,
	slava@dubeyko.com,
	viro@zeniv.linux.org.uk,
	brauner@kernel.org,
	jack@suse.cz,
	linux-fsdevel@vger.kernel.org,
	linux-fscrypt@vger.kernel.org,
	ebiggers@kernel.org,
	tytso@mit.edu,
	jaegeuk@kernel.org,
	linux-kernel@vger.kernel.org,
	kernel test robot <lkp@intel.com>
Subject: [PATCH v5 1/5] dcache: export d_find_alias_rcu() for modular filesystems
Date: Tue, 20 Oct 2026 20:26:46 +0000
Message-Id: <ad1e9d2c5ba4803f1c7dafc6687638b0489a7265.1792527529.git.amarkuze@redhat.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1792527529.git.amarkuze@redhat.com>
References: <cover.1792527529.git.amarkuze@redhat.com>
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-Mimecast-MFC-PROC-ID: a1oVOETQRjfuLb4mtz_uasj7uB-QfO8NmvkBBcHLC3E_1792528019
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

The Ceph subvolume quarantine ancestry walk needs to find a dentry
alias under RCU without taking a reference. d_find_alias_rcu() provides
these semantics, but it is not exported, so a modular Ceph client fails
at modpost with an undefined reference to the helper.

Export d_find_alias_rcu() to GPL modules so filesystem modules can use
the existing RCU lookup without changing its lifetime rules.

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202610171220.i77KPiw5-lkp@intel.com/
Signed-off-by: Alex Markuze <amarkuze@redhat.com>
---
 fs/dcache.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/dcache.c b/fs/dcache.c
index 1b1a81f10da6..13ba553081b3 100644
--- a/fs/dcache.c
+++ b/fs/dcache.c
@@ -1248,6 +1248,7 @@ struct dentry *d_find_alias_rcu(struct inode *inode)
 	spin_unlock(&inode->i_lock);
 	return de;
 }
+EXPORT_SYMBOL_GPL(d_find_alias_rcu);
 
 /*
  *	Try to kill dentries associated with this inode.

