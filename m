Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0B78387596
	for <linux-fsdevel@vger.kernel.org>; Thu, 15 Oct 2026 14:36:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792074980; cv=none; b=mYsaPIln6/1krYKpR9ume3I3VkK0fy2bv+SEqAmviK8BmGWtkbP+k74LPN4z0jyUZs1fsRb3AGF8M2OctJhQc0qp1aF+01q42ctcCVml1RbSrB3f+zpm599ibwiGlDyBGyz132lwrK1QYdk3vyALqfSMYtkJpovO/Abv/3gsVns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792074980; c=relaxed/simple;
	bh=Loe4ssx/bzLAiOnbpYVPAFiF0W25R9TPNYkGSVoRfWU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PgIdTvqOJurq1fPQI/iOi28Uu22KqTBlUk3kS5XuhMOFV6wWwbfi3nxXzHoxQCSHBM2WYJkiDStoOYJgVSmulLvA0TE2wdQxEbEjjX7vbYPbmMYw6Q4ZwF15YuYl03wI6a3PB6XhGNiBzf3QFdhg/WaFbJ47Pjspn1LInBqad9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ne/n9yFG; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ne/n9yFG"
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-c2a4e013a44so357223066b.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 15 Oct 2026 07:36:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792074976; x=1792679776; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=nAptNKWNJUEqL1XnRQAl60phE6PnhdBo1ykE5RsybUk=;
        b=Ne/n9yFGiS2M7XvepoFSwF3LQW+Pc1IWptlHCXDT5qBmbEbCHT7RzjBAzay5NH3bir
         5is5g64DuytB2EOjTcjJYwW6R97ecGFjm+efYLwnt+opm2+iKIh4zcQu38BITEtqYLfT
         Xw/2ta2AeP8LDKB/dVyxD2qwQMVHw4IyVbs6reOo8MB5xhTcgzsozPmD9lgvurKoGC1q
         4Ngzbb+M/ci3In2fXs2NXgGp54qWpbcokgVdAsK/5uEvcm8qWFRjs7zQl8yaUAaoTjUe
         JJHuDsyzi9CtSj96aeu6lji80/yOBKYGzMiTEchzI87GeNCVJGhF9gK5XqD7o5o76Oi5
         tG1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792074976; x=1792679776;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=nAptNKWNJUEqL1XnRQAl60phE6PnhdBo1ykE5RsybUk=;
        b=c3g3L/iPSU5XKxDLYE2ZbBjoc4FcfUkt66lwV1QHI1nCScmxR4y2uL8rs6dknfPtdn
         TEJ6sQscYzdxpSRFarFySs359yf4JHyhlqf7YThDnXvnai03X6qwYjg1twHpVobeksOK
         lVwE9B3EPhD0iHkEHh4J/xQOVjRRmE9tLz6/CLBymiy+9f6xPX2xtL2lY+ycgrXZ7Ck4
         PaU8wNy1pNXoshUuKUvK1UY2Lro2amLdKYye4+GfUsQCGPXq6Y75JTaO7eKemXAYS8et
         LkTc4q4XG21mPVBEJvEteql5uXN+XzQyEmyz79HsIjKuP8qpm8SgWZ0ou8Mea//wUo2V
         Zscg==
X-Forwarded-Encrypted: i=1; AKwUvBy2PmP8BDjWE9cV2hqGUNk26p5iwRXQp2nnHzV105zkkxrRxlkLCMx19juCzIBw6kyE5BH1svE3eFUGDIeq@vger.kernel.org
X-Gm-Message-State: AFq9FYKeaDD1pFnDp9mHXV269494cPe9jgA6QxWK6fiIp+bA74YQXCs/
	fZm7pnFiqJvqGVGFrqeD8gvoG6gSEjb9sIt2aqp2X6oPnrfaaS1D8I0oz3UAsM0m
X-Gm-Gg: AYBFou02DNZQjEMD6CaJtWlCc2p/AyrnkqGcXIRV63isUqK6Ck9OhcsHGPVmtKXqeJk
	oP+WjM2eo7wVciZXQ2plaiXH/84XNkkOliKy/sbS6/OZ8Dw3LAyawj7/3/kN99o13dNdxx2hS6G
	ogAEeZdMCU2vKxMeq29fIJVpE+DdfeDsYhsMO/stry7d0MurKzKD8OrJDIzhzZuPpR60UPEBzlI
	W0oB/SHimtYHRokHcLwfdFBaG09pG0mFsQ4TM6BcvbthnkkPMSdyvxkeBatIpoaloqv2fNGGgdE
	Gzn9S1nqfCVH1LrL3JPLl/LVwdJPv2z0ucdjhvniFgJPr71ukxjkrbgAbFoXzzl24xapXDqyHGU
	CZ2LzoutRTX/+r9+mjvQQ5xi0dGevis0+lNfPuJi8IWSBfL5qVMusoPbyuvFV7JUgIc2OOWpPyX
	4GFNA3/bDyBvk1skj6RiZxST1VJpbjXsqpJItViT9NEdCMAO4QfJ/G1l1juteq5WHYmMO+P2ZsG
	KJkD7/a1Vd8FPiBRlZlJ6Is1g==
X-Received: by 2002:a17:907:8d8d:b0:c25:5d2:acf0 with SMTP id a640c23a62f3a-c31a9b0b0a2mr1658026766b.8.1792074975704;
        Thu, 15 Oct 2026 07:36:15 -0700 (PDT)
Received: from localhost (178-84-201-199.dynamic.upc.nl. [178.84.201.199])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c3eda61faedsm133229666b.72.2026.10.15.07.36.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Oct 2026 07:36:15 -0700 (PDT)
From: Amir Goldstein <amir73il@gmail.com>
To: Jan Kara <jack@suse.cz>
Cc: Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH v3 11/14] fanotify: introduce FAN_EVENT_MATCH() macro
Date: Thu, 15 Oct 2026 16:35:57 +0200
Message-ID: <20261015143601.2095784-12-amir73il@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261015143601.2095784-1-amir73il@gmail.com>
References: <20261015143601.2095784-1-amir73il@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

With "strong typed" events a correctly written program needs to
use the new macros FAN_EVENT_MATCH() FAN_EVENT_MASK_MATCH() to match
the reported event mask in the scope of the watcher type.

Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 include/uapi/linux/fanotify.h | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/include/uapi/linux/fanotify.h b/include/uapi/linux/fanotify.h
index 0744b6770b43d..1f9a33d21c03d 100644
--- a/include/uapi/linux/fanotify.h
+++ b/include/uapi/linux/fanotify.h
@@ -14,6 +14,11 @@
 #define FAN_EVENT_TYPE(mask)	\
 	(((mask) & FAN_EVENT_TYPE_MASK) >> FAN_EVENT_TYPE_SHIFT)
 
+/* Match event mask to any event in @event_set of the same watcher type */
+#define FAN_EVENT_MASK_MATCH(mask, event_set)			\
+	(FAN_EVENT_TYPE(mask) == FAN_EVENT_TYPE(event_set) &&	\
+	 ((mask) & (event_set) & ~FAN_EVENT_TYPE_MASK))
+
 /*
  * Events that user-space can request when watching filesystems
  */
@@ -296,4 +301,8 @@ struct fanotify_response_info_audit_rule {
 				(long)(meta)->event_len >= (long)FAN_EVENT_METADATA_LEN && \
 				(long)(meta)->event_len <= (long)(len))
 
+/* Was one of the events in @event_set reported in the event? */
+#define FAN_EVENT_MATCH(meta, event_set)			\
+	FAN_EVENT_MASK_MATCH((meta)->mask, event_set)
+
 #endif /* _UAPI_LINUX_FANOTIFY_H */
-- 
2.55.0

