Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01A412DF144
	for <linux-fsdevel@vger.kernel.org>; Thu, 12 Mar 2026 17:12:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773335566; cv=none; b=MiBKMmIwrx449x2smATviAAtjKTQz/V8w4WAPTvviArRklOK3abdO2IhNP8tBd4EAbENqu808LpuTojR3D9CuSIOQvx3WcfOCwIMyno+2gGcLTbieaNAEy83s6Ko+7Qx1x1/Jt9rS/GsQcUsjwcy0GVr0zeSbo4DEXLQQnAnIzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773335566; c=relaxed/simple;
	bh=LwGy5RmfdnJ6CE3NTItB5tfCzF35fs9VhWXuqoES7P4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=er/8PgN++N1xztgR8yccxacbZUlrB3sLUrcMQniCCVbOU6VXtxxAPFbpujgzCnRm3p4LHgCaifI8ScKdOgNNEKQI9cgL2dpqVWwLyNBUV2fHxsqt6rAWGuV378djD0LOREpfE46F/sXe5KHILdEW5bgK6AB/ac7Z/nODDSbD/Vc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jqW4tvc3; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jqW4tvc3"
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-38a694a3cf9so11665071fa.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 12 Mar 2026 10:12:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773335561; x=1773940361; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Mg69a9vrgMcSAwKsm172J4h0Z4L6eK5f2x4mJHkOo+o=;
        b=jqW4tvc3JvLMwg30xjAN+92NMbmNd4W0gbSuUYP7n6sER803+5/Jf7BQqLxOuTTDQv
         XHoBBJr2SwUeUwOQjuq+r16TwyzG8MkKOpP68Q/lOv+aVYY1HYNIc+e9wsmaovCjJRVc
         rOe/76zMDdPFjm9UfO/ynzuqD6whKr5eDm7vDKKoyPK62sqMPXwVIQhUBXfPtQ9Fw6zm
         i2a++kBbIA8vgW/ItKZF9lj4aidAe4YR96B/fdsplf3bWxadMsVwqN+kwy7hMAmm+3Ot
         +7g2VFat38W1zFI74sc74ic7UVQNkJy9IH64ar5O2zyxE1qDi2GYnGcZG4OxGhr3W961
         +qhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773335561; x=1773940361;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Mg69a9vrgMcSAwKsm172J4h0Z4L6eK5f2x4mJHkOo+o=;
        b=oQrlBy+K9e0HtYRLCRTtZb6fpCUN+z48ADlhU9JN4aTOkxRc95tu5MnSi2WGpuYUhY
         Rr5Av6jWSWgh42X2rTyVkRri8OFG9Yr2yB/YGbWUPCRbWxQMx6FEYoUr1mFj1/ff9ZPH
         5+dluiWZGlwLBqEF6y8ARciHrVPveYemc/ABkT10XNeczxIhxm5hb4XS9SPqNOBqlf5O
         aOYDRn4kG1mEOwP9rhmoBnfmk5q6wGR4tUcTQZ+wJvto67p7HGk+TDyYf90L4r7Tg+mx
         QftFu7BpL+UWQbubme04M67hSWRS8FnYh/A9Vgctf151WQzjfya2Gj481xJTq7gGph76
         YFDw==
X-Gm-Message-State: AOJu0Yy9S4NnMglpuB1Bpari3PajHShhvb4ouQEz7Tp60rTdKMJ2BjYc
	0FHNAL91TPHvcBtM5WsT4FkW+q0PtpOwwMRJWGhehQkzZmJ9uDJircN9fxD9sH4T
X-Gm-Gg: ATEYQzyh5f8CaVk/asRDHOSeUg3XsQcWXkQXX8HmPKxvemarKi9wGED444f0nYq2jSk
	Q9E99CS2IHy6VZLF3dAbKrAqmpq0HBxWYUVbOUSKy8niOYoXi0eokcLDuuaBddtQ3gGix2a7T/g
	F7aSL63Wt54UI6XxXvL63IPMTFfySTU8GmxlunH9N6qJ7N98lWZjgMpGASh2yyzUPU98fqhM3pv
	k3TmHfkuCuorHstfel1kb1/oDbm7vCnvh/U1wxwloLCR+Kv9xxnnM1aDg0W5rAiFEjTDTbeH8tp
	53N8P6TMnYzfF0JFchG7QYyHY4euK0ZYzrpe6ERmSG6mWRoOCAAgrYrYKpvvh8iJqmK9pFkT27N
	iNLiwx3U6hZe4GhQpGkezzY59JKIPGLk2j+bk4i+LEgALxLHcqEe9arFSP+EKs03ZYgKulmBfzq
	4dKbKFk/wr+GinbgX1jvf27tRAUgCcWolTfJM6lctijT8Xkpa4K3PYzQNhBXhp2y85DxdMt3cWM
	irAWhMU9Q==
X-Received: by 2002:a2e:bc92:0:b0:38a:437a:516c with SMTP id 38308e7fff4ca-38a896c3ebcmr233521fa.17.1773335560464;
        Thu, 12 Mar 2026 10:12:40 -0700 (PDT)
Received: from ubuntu.. (static.159.107.27.37.clients.your-server.de. [37.27.107.159])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-38a67d6185csm10401921fa.3.2026.03.12.10.12.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Mar 2026 10:12:39 -0700 (PDT)
From: Josh Law <hlcj1234567@gmail.com>
X-Google-Original-From: Josh Law <objecting@objecting.org>
To: Matthew Wilcox <willy@infradead.org>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Josh Law <objecting@objecting.org>
Subject: [PATCH v2] lib/idr: fix infinite loop in idr_get_next()
Date: Thu, 12 Mar 2026 17:12:38 +0000
Message-Id: <20260312171238.7961-1-objecting@objecting.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Josh Law <objecting@objecting.org>

In idr_get_next(), if the returned id from idr_get_next_ul() is greater
than INT_MAX, the function issues a warning and returns NULL without
updating the *nextid pointer. This causes a soft lockup for any caller
iterating over an IDR (e.g. via idr_for_each_entry) because they will
receive NULL, fail to advance their index, and repeatedly query the same
state forever.

Fix this by setting *nextid to INT_MAX when the bounds check fails,
ensuring the caller's iteration will terminate.

Signed-off-by: Josh Law <objecting@objecting.org>
---
 lib/idr.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/lib/idr.c b/lib/idr.c
index f25bd2b9e9a4..07098eb4ddc3 100644
--- a/lib/idr.c
+++ b/lib/idr.c
@@ -268,8 +268,10 @@ void *idr_get_next(struct idr *idr, int *nextid)
 	unsigned long id = *nextid;
 	void *entry = idr_get_next_ul(idr, &id);
 
-	if (WARN_ON_ONCE(id > INT_MAX))
+	if (WARN_ON_ONCE(id > INT_MAX)) {
+		*nextid = INT_MAX;
 		return NULL;
+	}
 	*nextid = id;
 	return entry;
 }
-- 
2.34.1

