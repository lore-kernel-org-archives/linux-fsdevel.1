Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8D314908B2
	for <linux-fsdevel@vger.kernel.org>; Sat, 17 Oct 2026 14:48:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792248530; cv=none; b=d5+ZyZShnpmRsNDsinnidxBaPGNNR/h/+JIfTMa9c97UlDA3Ly9ZzscjgxbOBbvg6EZpdwhlct3//gBrRKx4CdNACmi7USwtzw03GLmJQS5X781iIiAm5Pk7yuIlTPExpvtptwnk6ak7hkzB+ZFqAtVw/gfl2xiqIFjhwKK5Yuo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792248530; c=relaxed/simple;
	bh=L0SvlG0HgqpzEKFEwHq7wDfZkYZ0WTBPvieUdovJWzY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Xrc9i9e/upJS0jr8NML33jD1y1ufRYi04RtSC/MY5gjGrymdEliUFfcOPiVjxYFI00/+v44dLyefykgwyBt17QOMNzx2KudFKJ4qQAkUSqtABceuGMg+z8bsbn5Jt2HJlika18chS5dZSBmJvu3Q3oPO6q9YwDjjdJ2XVCAfzE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JaIQeg2a; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=mwR2yhB8; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JaIQeg2a";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="mwR2yhB8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1792248527;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0ycK1hfInrWAuob/OJzi5liuKRYAR110GQUd0Dl9JT4=;
	b=JaIQeg2a6RDpvNEt2MrRX+/q61RPED4XrgSR8TLP7ZsUsi7enNr6atQQzGXFMr8Rh8JB5Y
	6Asuf8ICaFqzXmQC3HUPbKenYDoJGhrNr5SSnBiPmUxjhavKW8CXQ+TXCmsrGTiI9+7hqc
	GSCvTb7WVdASWRn8kfu/tN+pIK4szi8=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-407-BhlMNOSKOUKb72qU8e94EA-1; Sat, 17 Oct 2026 14:48:46 +0000
X-MC-Unique: BhlMNOSKOUKb72qU8e94EA-1
X-Mimecast-MFC-AGG-ID: BhlMNOSKOUKb72qU8e94EA_1792248525
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-c2dd399f761so72973466b.3
        for <linux-fsdevel@vger.kernel.org>; Sat, 17 Oct 2026 07:48:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1792248525; x=1792853325; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=0ycK1hfInrWAuob/OJzi5liuKRYAR110GQUd0Dl9JT4=;
        b=mwR2yhB810IIeuLh271hyganFDEGKE/Imjam/DWVtpOjvNl/peSCXOovdayhhoYECC
         iR23dn0rrRItdLRzwtZpYsQQrCpRhAFZcMTmh+k81EtLg6j40+lVUP6yHDmVgj5xoLTl
         CCV362uHbBEyMNZx0HIcb509GsMnYdBNgntZfcUcpNpCGqHfDC5U/zQ5L2+EyVQFFdQD
         JSvYsjNlErEHqv6kSi/Tf3Ei/iAIOo/RekZBGlDjvSNZ791XOFR5Ump0D/5o0fGW/M21
         6eCKWDnPAAmSrtVFxTmzDTWnrLJ937LukuJvZyKebtex7FbYSd0U2yQKER6a2dMS/ZZo
         m4tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792248525; x=1792853325;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=0ycK1hfInrWAuob/OJzi5liuKRYAR110GQUd0Dl9JT4=;
        b=QnJnV4I4JpPA3MHXy7wS3MM/NmQnN9ZDgtJKdZkh1N5gqR5zqLV1vPJ0Z96KCNcXHS
         rQLKIKllg3oLnsvZRfC2ulHvg4Oc+UggX9Ca1FC07jQ/rKL+bXJTjuxfPM/aJ6IMXm54
         VrXQc30ykSxa1yoEbOanuJRizhtEeWepKshduNMJAGzxyaOpzf2icPbGBmDtW/MaM1hb
         3bEXmqphoxJ8X6HDGIgN3hpjUUC44tG5jjiqsByyd+goBTezz9eaHvrM5aGrTGQfZ6CI
         E6CKcXSRDT5EMzS2iIfC7kis2qwtKjAhSHpa3QPsA21HXJXbBC82V4WML63X0Q5P+3J/
         Wb0g==
X-Forwarded-Encrypted: i=1; AKwUvBxxK7vP/0JZ8gQTt/yfNHKL++rpmAvw85UrS8wnl7QvU0wYo/7EWu3PeanEuRxBkJVjjO3mgXUegwzz3em+@vger.kernel.org
X-Gm-Message-State: AFq9FYKyh8Sjk7nNqfl0LPrGB6RyCyP3vW9yqyLGoq4YZNMkp20vF6B0
	njPYTCMgpTVO3a4jUB45MojWNAMHoAflBsny/oIobq23LERPAJfCyTGx3lnEOSB9RIbmACiV9pm
	wKvETtl6I1DE+VOFWxJX8xmS5OVxl+yoyXSopBieXAI2RP+D2vn61JWbXGdlfZCRGYOk=
X-Gm-Gg: AYBFou0Dcm0B/ZzCmblD3RcM6c5SMZeU0S6J8kzN4QocBG37oQN1YlR7g7mXCY/39Qg
	ToW/yoym3XmOLh4hhp1rJMhoe5W3OnohUe3lpaO+PG6/J2wWzatrSH+jwJuXomQzTz3RAgpRoy6
	+FCiGJK/Y7xXo0zByQHhaIs9oZ+DVu2DvmM/P3kQq9UE4TH0uJdqQRXSb/RjuK1a2sn7VCs+ffj
	5z8q3N2JHsQr3lDxxFdA0zwx9zEwm/DgdbZrUrxHjMMEflFqm8Oj49Xv+sopJFmw3wEKP3QSy1o
	o3gD/2QkmRoe4vgoLPVnqZIApv8WW9lYC50PqIwFccSa837m1orhU9/tBALY9/yEq2Aqm3zCeXs
	XoDciI7NQ9ZU0w7otOyFUKLlt1asM7l8ar0LPlLmIUwFy/x2oVB/W/UIx+i4qdMiEc5Sugd9oLC
	Ihg3SQFdX5Fm94ygpeGhZZ5/WDO9pfWhyillOMxJz2lnPdf0aOqLsNVKIWjCwm35gm5CjVMvheA
	4U=
X-Received: by 2002:a17:907:c00d:b0:c40:80eb:c541 with SMTP id a640c23a62f3a-c419a05d6d0mr181163666b.2.1792248525272;
        Sat, 17 Oct 2026 07:48:45 -0700 (PDT)
X-Received: by 2002:a17:907:c00d:b0:c40:80eb:c541 with SMTP id a640c23a62f3a-c419a05d6d0mr181162766b.2.1792248524879;
        Sat, 17 Oct 2026 07:48:44 -0700 (PDT)
Received: from cluster.. (4f.55.790d.ip4.static.sl-reverse.com. [13.121.85.79])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c408e32878bsm181645366b.12.2026.10.17.07.48.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Oct 2026 07:48:43 -0700 (PDT)
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
	linux-kernel@vger.kernel.org,
	kernel test robot <lkp@intel.com>
Subject: [PATCH v3 1/4] dcache: export d_find_alias_rcu() for modular filesystems
Date: Sat, 17 Oct 2026 14:48:36 +0000
Message-Id: <f93b4a902ed00af44019ca88eeffbf686d920e2c.1792248177.33a6e2db0a.git.amarkuze@redhat.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1792248177.33a6e2db0a.git.amarkuze@redhat.com>
References: <cover.1792248177.33a6e2db0a.git.amarkuze@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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
-- 
2.34.1

