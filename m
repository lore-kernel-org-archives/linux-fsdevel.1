Received: from mail-dy2-f32.google.com (mail-dy2-f32.google.com [74.125.229.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E066B38DC64
	for <linux-fsdevel@vger.kernel.org>; Sat, 26 Sep 2026 04:38:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790397526; cv=none; b=WUk/rjtlek+AGmn5YLHFVMX0J90aEEYOeTsK1CtdkIFq8DA1KGdnSusUBO5KTKnhOpuREGrte/tqd6AzgBh3ng9G/CDT2tsQFgB85F/hpMbIjiKOLwBcgO4YWNgztfbd7Cw6amPBS4dC3pkHIPdDg+5JbfHHW92TwUIoq7iysDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790397526; c=relaxed/simple;
	bh=ZKthYkVLB0W/m5QNSVt9SMTc5DimJTTdamI23CukwHM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=owPuQ8MezOmcexA499PeewGfce/7qThfCAuGRGPooQX1423ZjeEl15oQB7CvXNWcZRHDDYOonQwBNHr7YvyOxeKbtYKCELFRBemMN29kdx0WT2utZvNl5CBO/od4fPukQvwhCSAOSjg6J27CiJlxWu1fzhKVKPkQ+JcbKyLpTBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ajQZ2/3R; arc=none smtp.client-ip=74.125.229.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ajQZ2/3R"
Received: by mail-dy2-f32.google.com with SMTP id 5a478bee46e88-33b9e805130so1061640eec.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 25 Sep 2026 21:38:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790397524; x=1791002324; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=POU2be3xOrNpJVPniGd2Zki6uY3mDzNBbyh7LRzbWAs=;
        b=ajQZ2/3RNxCF6L3Cae4nx4FL2SfAlNODSYeFp8B3HnplXOfMEurxBleClST4+8gMXQ
         GNWGPmr38lWj2IdYq9ByODEdGw1xazp3bXMR8v/fivH4vSvrh4+zC/mPw3nLpf6JT/IC
         HuzgBRyQl1Ab0yrIe0P5yPDWgpnIfAwo3kZT4zhrO4VLtWWjQSvHy2NAIIhOC2qI1nHe
         xPAp3LxcIkYnbrpAJcqEXzbWSc7YCcqp3s/ZtUsrSBtS8j6uuNwdDy+ps4TwB4gCmWho
         fcnyJRZ9JBFml0kXsycFcXnUhZ04Kd8D34ZwFJrJjaTHnD8Hh8W0cWgvUz+hpoJK/go6
         c54w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790397524; x=1791002324;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=POU2be3xOrNpJVPniGd2Zki6uY3mDzNBbyh7LRzbWAs=;
        b=bb1GtQyHQcbyxMLYC7Y9uBKpxaAQ5iGwZ1vPO0avgw4F0GQkBTf0f2DLjt0ZXQAHhw
         64UoSSL142jP9O1FXqnw+ECRA8nYCDsPqBu1CSKlpWZUJ57aNSVySTkQfU92r/VEve6Z
         u9CAo1WqIq4nJNjdr90wwpy6TJRzTuEcWRPe3S2oFVCCaLt4HIgzgJCTbeB83E6s2+vr
         nD0oeP+CrTKZYbujne4v4877zVaKduh0XvpC4ThYm8XpBkl/l/S4BwLq7Iqd2937XS1n
         o1B2RVR8SYyzAlXUcdhFaQNGE9DTF+XOK2PPTWbGRyr6LJyKCAl4sJA0BWlgEpgornf9
         Fnhg==
X-Gm-Message-State: AFuF++md97Au+T8aF9mMwzkdvcYFJusFSzC6wTAMVQbF//qAfOAHTHSO
	AbXOMIj07mp0ocN5+kVL/ZKpOxmdQwTcU4yOW0jLfrM1XNgz+xlL5p6B+o0bVv26OzCQBshh
X-Gm-Gg: AYBFou337FCDyaAmEHzzaKEUPaZuVvLRqo94qkXfFpPK5mvjundOsYfPW/EfUX6MUst
	SEQdZFKIw98LA6ROIZG1TQv3zd8+BK80sGnBsCYZtOaJ8e7DXyFpMUTwynMPKpSbAfzoUlW7eGF
	XW6AoNlE5fUyorc5Vv3a5wv3o91qpOGU3iuiOzL3qeaB1+I3+gRCA13JLEmc5hG47iNsW0MOJZx
	ScFzvrTSMVX18se37X0DEwji+0WdkLQMRLTLjDS64eeNYtiDLbNVtOixjoNey7yJJOYEV2PaaKG
	3ThAIgm9K0JpZHMq8Az3sWxZO+W5rGx7VC0i3kJ555dJNNSQPXBpOy3KlXrV/a0JR/MEgEsj8ep
	622FBrUS7UiUOjpwifJNBO+b/XsVaUbnUPm7lCHzyxaBv3Cc3nYEF9wo8WksbiIqwQK6tUVRd+g
	xE7OAhNCYdAEjT13OlvX8THqmzJ+JsMadw/YOxNTOpQceljM18dHL9T+o4jWnYoKFlg/n/qnHIe
	TR46f+2HyIcMKjVzYViApztbWqpB6sHA256vM+zEx/ECr9g4Lo8WXso+8gfA9AcUmlUPNfOiQw9
	GbQ4CwXx+XaBLgFrGjMyunJ2u17SFCj9P2itZSYFk340+7Aw1lCXuFVwyaQ=
X-Received: by 2002:a05:7300:c8cb:b0:33e:d4ae:e10e with SMTP id 5a478bee46e88-342746276b6mr1952224eec.40.1790397523897;
        Fri, 25 Sep 2026 21:38:43 -0700 (PDT)
Received: from spider.bream-herring.ts.net ([103.6.151.236])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-343025a591csm2171406eec.12.2026.09.25.21.38.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Sep 2026 21:38:43 -0700 (PDT)
From: Matthias Goergens <matthias.goergens@gmail.com>
To: linux-fsdevel@vger.kernel.org,
	viro@zeniv.linux.org.uk,
	brauner@kernel.org,
	jack@suse.cz
Cc: linux-kernel@vger.kernel.org,
	hch@infradead.org,
	djwong@kernel.org,
	david@fromorbit.com,
	amir73il@gmail.com,
	ansgar.loesser@kom.tu-darmstadt.de,
	Matthias Goergens <matthias.goergens@gmail.com>
Subject: [PATCH v5 1/2] dax: return the comparison error from dax_dedupe_file_range_compare()
Date: Sat, 26 Sep 2026 12:38:35 +0800
Message-ID: <20260926043836.3301898-2-matthias.goergens@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260926043836.3301898-1-matthias.goergens@gmail.com>
References: <20260926043836.3301898-1-matthias.goergens@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

dax_dedupe_file_range_compare() returns ret, the positive result of the
last iomap_iter() call, when dax_range_compare_iter() fails. The caller
treats any non-zero return as the result of the range preparation, and
xfs_file_remap_range() returns it as the remap result, so a failed
comparison on a DAX file reports success with a small positive length
instead of the error.

Return the error itself.

Fixes: 0e79e3736d54 ("fsdax: dedupe: iter two files at the same time")
Signed-off-by: Matthias Goergens <matthias.goergens@gmail.com>
---
 fs/dax.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/dax.c b/fs/dax.c
index 1fbba0d21c13..de11bbbb6a38 100644
--- a/fs/dax.c
+++ b/fs/dax.c
@@ -2264,7 +2264,7 @@ int dax_dedupe_file_range_compare(struct inode *src, loff_t srcoff,
 		status = dax_range_compare_iter(&src_iter, &dst_iter,
 				min(src_iter.len, dst_iter.len), same);
 		if (status < 0)
-			return ret;
+			return status;
 		src_iter.status = dst_iter.status = status;
 	}
 	return ret;
-- 
2.55.0

