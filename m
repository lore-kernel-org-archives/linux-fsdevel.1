Received: from mail-pz2-f12.google.com (mail-pz2-f12.google.com [74.125.228.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DE593B993F
	for <linux-fsdevel@vger.kernel.org>; Sat, 19 Sep 2026 08:08:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789805333; cv=none; b=BblXY6F7zYIVt151SAGIv5ow6gmTywtcF64fVBoLcFdiTPweFiEEjzHRPlSwPe2mgfHedMFkIoeducrMQKXzGAOUYGzqIfmufiKQ39Xc4z8K8dqfQF2I8Y5i+LBQavTbEdlghv8WBi5Pshv6B94Mj5g3w1hd74eWWQn/C4J70uA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789805333; c=relaxed/simple;
	bh=ib6RrwaF8264n/SLla5qex79A7ENGDfeGW8kW+nqFxE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nlluS1RRvASqv8gzpUejWOkP+dJHlSR4FEZe7hi9vof+qyEH/NnatQvCsxsOkvyRd5Za/Qgo3LU1x/qwpBTlmu6hV7A1xg/2/LGuknakmXZtR0ofhiws4IOQzmGX6GhenRqYg8rclYopdRbv+r1sdIs7l6EJ8sBJoa8YTihUvZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pHVUbjHy; arc=none smtp.client-ip=74.125.228.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pHVUbjHy"
Received: by mail-pz2-f12.google.com with SMTP id 41be03b00d2f7-cc4cacd3409so1639420a12.2
        for <linux-fsdevel@vger.kernel.org>; Sat, 19 Sep 2026 01:08:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789805331; x=1790410131; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=sVrPSQXkAQAeBNMiZeNw0hR8rd7g3NRpI+w/G9sv39Y=;
        b=pHVUbjHylnUqUVRBHfw7yUJu/NrqrT7H7n4JW2uA6xqSvHJ/CvpnTYuVrD+M/cUvQk
         0rreVrn3fhgggP0EyBd51iNf4qjY309lSoRFm1flVhGQtWBoOBHl4pdjMeJcFrUiBMLB
         Igikw/DccTodkJprkHdj7vyHzO8TlLuElJ1ewqpmivnRg5pCa+4FF4DPplogP/qEQk6C
         lti4s+ITQWKTtbxcvPKWUZP+o814G+1a6WTnJUzUg/QG3key5DlHRGBTR5zDwmdzU7bH
         4UV01sbzvYkEtGY6XdlRgjiiPwwpnW5Z4ZRAEO4R7YteCNCvmM7SBMDapfMlUwoywIZm
         0WiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789805331; x=1790410131;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=sVrPSQXkAQAeBNMiZeNw0hR8rd7g3NRpI+w/G9sv39Y=;
        b=wCz5+ZcFZOcS/fICToaj5Id+3fgoku1Pa97FpHtgfKBb8kDwP2aUNIn56N6orpCT9t
         vO2NJ1eMM6+4hU+4aPWeFc4jfce1y5SeuaCWjDfFZREfXrPVi1La9e4wzD4CAt5rwrVd
         HJLFCPrN4KTinHXvT36R2q/gvPddFCucJTSmq/u63Zp6cmhWkxjcGrKymX0El6h1s2hY
         25eOmZts9qvAr0RQbBidMN0JnEKSBe7u7UdQOq3tmt49LoMSculWjYmNxZL49Zn0m9cS
         M/InYKzNfv4L1STOnogEdtS2vYRIuNazwRu6P6QshCT+UoQ4zdDJHLCttzUAaAeU3wV2
         fNRg==
X-Forwarded-Encrypted: i=1; AKwUvBzUKYTBYiJidT4qaizVryTgLIzt04UHX0XmkIPJTks58N+kLFFhbvroTlO6PjUbrkT5nGWmqHoDmRTeDujh@vger.kernel.org
X-Gm-Message-State: AFuF++kvKv1g+MYVxI1KnF4xqUewH5ZCBy5Z3KHs9bIqWNUV6PKqk72X
	zwEOU2roBeyzJ+0qSOUErWpyE7PYSh7492T/D3c8hj+/z2KoqpN+5UowYAEgvSIB
X-Gm-Gg: AYBFou1og2s+54IjWqau4z0gmJ9odssZYDbpsu4zbDQAxba+cAQgtUHymW3+GboWEEQ
	TGoAjCm+exxzcURlp3GrKuJobsgX3LSPgjk1XGpNRxOA3JltkWzpy7qsMxUzMGoh1YOkA9T9F2E
	7mQAow00e4Uvi+JBka5jXrHpAfopAU+TnDKNyAEEtsXS19pAGjtJmz71AYDieZdLQ4Wx63ovSaU
	G+ouO01yojFrsYkfSh2m2CoEbdZRZ47dJW/9qCZhC9IC6yN63+Fdd78A7HLKS4ZUp8UMoNI9JG7
	ies9H3lV5pvUt2l4LXnwCWPOEMhiucceuX8nc6wyAR1AqtvFRZfDMEXT8ISYi4lpyrvASAjLffX
	n6gVQmLZG1QWQXcfQEeuM3FiqD76FfNZuVvK/eyHnRRDabH28d7y2UuViqD9v9T6nISRK0T3k04
	TUV7qxNma2dGVcVxIN0Q0rmNLaad9BLcEdDBGO67micfSV5mg8bN86JNdYex+KhpMVQ8fm319Bi
	3gBFoqHYOJp3Hu3X8ehDef98nQqUS9pWLFaFGq1CkWiRQjZxiu6dJGFdwjc+tOK5fUqylquU5Hi
	FoNbfSyq3Q==
X-Received: by 2002:a17:90b:2f0c:b0:39d:eda9:febf with SMTP id 98e67ed59e1d1-39e54ea5e7dmr10323255a91.18.1789805331369;
        Sat, 19 Sep 2026 01:08:51 -0700 (PDT)
Received: from phui-2.c.googlers.com.com (78.123.83.34.bc.googleusercontent.com. [34.83.123.78])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39e6f1835adsm2998296a91.6.2026.09.19.01.08.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Sep 2026 01:08:51 -0700 (PDT)
From: Hui Peng <benquike@gmail.com>
To: Christian Brauner <brauner@kernel.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>
Cc: Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Hui Peng <benquike@gmail.com>
Subject: [PATCH 2/2] nsfs: fix namespace reference leak on unsupported ns_type in nsfs_fh_to_dentry()
Date: Sat, 19 Sep 2026 08:08:50 +0000
Message-ID: <20260919080850.3005810-2-benquike@gmail.com>
X-Mailer: git-send-email 2.55.0.1082.g2b9226bbc0-goog
In-Reply-To: <20260919080850.3005810-1-benquike@gmail.com>
References: <20260919080850.3005810-1-benquike@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In nsfs_fh_to_dentry(), ns_get_unless_inactive(ns) acquires an active
reference to ns before switching on ns->ns_type. Unlike the CLONE_NEWPID
error path and the owning_ns permission error path, the default: branch
returns ERR_PTR(-EOPNOTSUPP) without calling ns->ops->put(ns), leaking
the namespace reference.

Call ns->ops->put(ns) before returning ERR_PTR(-EOPNOTSUPP) in the
default: branch.

Assisted-by: LLM
Signed-off-by: Hui Peng <benquike@gmail.com>
---
 fs/nsfs.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/nsfs.c b/fs/nsfs.c
index a1842e12f..e9cc09583 100644
--- a/fs/nsfs.c
+++ b/fs/nsfs.c
@@ -624,6 +624,7 @@
 		break;
 #endif
 	default:
+		ns->ops->put(ns);
 		return ERR_PTR(-EOPNOTSUPP);
 	}
 
-- 
2.43.0
