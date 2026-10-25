Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792953773;
	b=nflRjjwNahXtT/X1uv/LbjpV6XSJyNe39IsyX9tfAdZmKvOQXjWSebL6jFZBuXqkNJCy
	 jfdzLX2nu/ZqaucBfrrAHpZGmOOmRitBI1QtBQ3UF2K+8c0HgnOPNJOcGCfSBlSJVekQk
	 odGhc3ncoppDvqxQNQENdOVvPrzJwvcLlS51N+QZLOZEC6rYsZj8ThHDuBBvcis6BT4dr
	 o5WwDXcQ+xjd1BQgQP7Zrs7+R0duGHkafm8BGxlhSR0Zks10kSXX6S2qtbLekcAmuuOGK
	 /qTgSnbJ2E1DpL4pQxe1GhKTGkVBQQmg6RMDKnTeFCAKr1RYVjtpLLZ/zfDYsAtnIng==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792953773;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-Id:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=MWImOuQ6ypazyDauHnpT+aNeaPFSVLwAEzW6QlQDKXg=;
	b=4JF+3puRbK14/F8hAMnTDk5t4r5vBJKSRJnDWR7WxbBLdbOOyiigqR3VH9DxrZrQzzOj
	 o3DcL7VVZUkTdAIZy+5eJjg8YzgszDsq21M2hyZiw4FS2iFd97AlXSEbtQ5P8WGhklLsy
	 9uBI+xa5uYqClV57jYWt7NHjoS/p+VMH0lScTcgOne15XrqwfXPqDP3BsIr0SSyHQLQRx
	 xCM91zRUOSsoLiToXNxqKKgAl8hqkRyDjW/pzrKb+4LKWBTdLCnjZMBp4sNog1LajS7Fo
	 tngLE+FRPPl2PpeLYecuQA4Orq6HqPXSujLFE/VvCr4ZRkOhio4akpYds2l7hb3bkoQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=YnhCpwT5;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=UM9gNfOc;
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39E8C606A320
	for <linux-fsdevel@vger.kernel.org>; Sun, 25 Oct 2026 18:42:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 39E8C606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=YnhCpwT5;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=UM9gNfOc
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1792953772;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MWImOuQ6ypazyDauHnpT+aNeaPFSVLwAEzW6QlQDKXg=;
	b=YnhCpwT5oQvz/xsrUA0NmjLzHab6GVhBdslYCvVwuNxMQiVjFWyHAAa7MZzA9rbsHGbJrs
	XF/ZiF3OT5B6xMZt+Gvat+tV5TS5jnaZ8FXoBApC3GYIW8tmKPWWGSgXJJtLxMpdQl5yTL
	2NlfnPpV/D7R7vAg/TCqQRF1aGmH29c=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-571--RcWt7UTMmWjEtJyrTPOdQ-1; Sun, 25 Oct 2026 14:42:51 -0400
X-MC-Unique: -RcWt7UTMmWjEtJyrTPOdQ-1
X-Mimecast-MFC-AGG-ID: -RcWt7UTMmWjEtJyrTPOdQ_1792953770
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-c3613c35145so256373566b.3
        for <linux-fsdevel@vger.kernel.org>; Sun, 25 Oct 2026 11:42:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1792953770; x=1793558570; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=MWImOuQ6ypazyDauHnpT+aNeaPFSVLwAEzW6QlQDKXg=;
        b=UM9gNfOcWXQfA6+mcNx2oOQLAI7uqUEEJFZll8z+z1ftL3/5ziQNEzQZ2OVoqKwM/Y
         SNSw00ojeXr7N5jtYuSeSmSMQgS9ml/ddfALqfu8o6Fl0t9twnlZBDuUOhPEg3IdskWh
         5TG0xGt5EXyDYYVjdcoduwqJEf1arIEMiBaS4EUdyhJm3bFZu9j3kccBjnwUuIaB4I73
         /W8AF1sw/drE6ylMDrWiNEaoHXUVzKHZhOBPHAVE8oFN3orLP9zqagTldlOmG9tmSFnQ
         ZjXQBNGhXrMnPUsHVVNuIF2Sia8pCLtK4Bbq9jNdDQuCpP4YAH9uHRF/GqeNBJkvB6sE
         dvng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792953770; x=1793558570;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=MWImOuQ6ypazyDauHnpT+aNeaPFSVLwAEzW6QlQDKXg=;
        b=VMmXwhzr02s0Px8RKd0r5GFU2JeppN2LsxibZWqAjCMfHxc4ARtNFMie/gbdA38e43
         2rjbi6cSNejVG0MxO/COoFi4AARv8jnNd4krSUHdn2nfspCCpb9ADIZOm/j2jmxFKLKu
         M8GS5Y8wvyDdRDLhL5LJik+UxZDPQs5L5idOSyR/XrsVLL5GgwY1q9IqenbBt9KxOvBf
         ua8rGr+yf1E3rqqDEEzJqTiHntZTIPw/gGQ+plwR6zivhvFcOBnbztGPhkjURPUWGpBU
         zXOV+T3EJlRsWx1ICBY9AsvaY2hFF/s5tsdzUYP6U/x+1N3GCBPYqElB7r6hWu8o7Dm+
         BHnw==
X-Forwarded-Encrypted: i=1; AKwUvByeFkbOlXiQMnPngs//jeH1L/vviBXC9cZRDNmoEgmtaVFJK0xfBpWuvV1RMPYt7Cnvm/tVSo3FClnBVgn8@vger.kernel.org
X-Gm-Message-State: AFq9FYK3dTdzeIL2O0dAJG8uvrEznO9DF7tx7sVfttXbW3HlANgcarjx
	gLecPYkbKO3bmF2j7NmtNWwABa8jNFXyUDr87MKgtQhk5J/i5HXXeBBEOAk3JW5WW86u/47nJPB
	srcdrGoAM4PTe6eLJIsCaAK1IjCHvsoG+vqFmpq6z176MMoYKe4hSaKpqXf+fZob/g6s=
X-Gm-Gg: AYBFou1uY086Py8oDy6lQa5U2tGWydN962Ji1LE8HnIO7AwiZCGrv9brTWEqRVjQ9Qr
	JYnuTh7C8RNXHif5O4pY5BD0ia8gwD93UNUMdAydH0dAC8cUTwEHhO71QXWxgY+NZlOeUoN9Xv0
	iSTSgrAXzO/ZItor6S0zTn9YWrfvp3uuVcvY85s6Q5j9DnGkhAlOdm+GYszoTEsghyyc4eb3YAZ
	EkZL5mxngtjlRKXTUyZYBqrSYdkemxQO0Mg+y+uIUs7W14384zDWdyWQuTW9toCz8eB5Tzsj7hy
	FZZLKkHP4aunFw9aVAheEmHY64u6gfwcuR1Qzkn5DOBqfI4NHWA95YclVS+fQrxVbfdgqiEQH84
	mOVSv7wN11/hpcFkYwn0pZ6t365Uj6U5KDsbIyNHqAssr39KJncqDIzp2L2Mtr6JXX6u1Dwtf1P
	Gd0zkPgWRphkzujdNGvjbNVstmbxJr2soWvC5or8dq9+aD+ZM1qaAomW8b3UI3N3SGCeI9jgDty
	ow=
X-Received: by 2002:a17:907:a095:b0:c42:24ea:3227 with SMTP id a640c23a62f3a-c46bde93411mr663662866b.31.1792953769826;
        Sun, 25 Oct 2026 11:42:49 -0700 (PDT)
X-Received: by 2002:a17:907:a095:b0:c42:24ea:3227 with SMTP id a640c23a62f3a-c46bde93411mr663659466b.31.1792953769487;
        Sun, 25 Oct 2026 11:42:49 -0700 (PDT)
Received: from cluster.. (4f.55.790d.ip4.static.sl-reverse.com. [13.121.85.79])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c46bd66e51fsm230750866b.64.2026.10.25.11.42.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Oct 2026 11:42:49 -0700 (PDT)
From: Alex Markuze <amarkuze@redhat.com>
To: ceph-devel@vger.kernel.org
Cc: idryomov@gmail.com,
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
	linux-kernel@vger.kernel.org
Subject: [PATCH v6 1/5] dcache: export d_find_alias_rcu() for modular filesystems
Date: Sun, 25 Oct 2026 18:42:41 +0000
Message-Id: <99467b57d12e5b671246aa5e216ddce3a7dc3923.20261025T182649Z.ca9ae7a18449.git.amarkuze@redhat.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.20261025T182649Z.ca9ae7a18449.git.amarkuze@redhat.com>
References: <cover.20261025T182649Z.ca9ae7a18449.git.amarkuze@redhat.com>
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

CephFS subvolume quarantine needs a dentry alias for its RCU ancestry
walk without acquiring a dentry reference. d_find_alias_rcu() provides
that lookup, but is unavailable to a modular Ceph client.

Export d_find_alias_rcu() to GPL modules. The Ceph quarantine state
handling patch uses the export with the helper's RCU lifetime rules.

Signed-off-by: Alex Markuze <amarkuze@redhat.com>
---
 fs/dcache.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/dcache.c b/fs/dcache.c
index 1b1a81f10da67c608704383086c3facb64ee3b3b..13ba553081b33a54fd8d1cac5cbc55d0149e4ad7 100644
--- a/fs/dcache.c
+++ b/fs/dcache.c
@@ -1248,6 +1248,7 @@ struct dentry *d_find_alias_rcu(struct inode *inode)
 	spin_unlock(&inode->i_lock);
 	return de;
 }
+EXPORT_SYMBOL_GPL(d_find_alias_rcu);
 
 /*
  *	Try to kill dentries associated with this inode.

