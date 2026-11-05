Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793890690;
	b=JUZ69yKhNEpFslbjYfbLuPRNvVABW9PPdsQtj2ImTMUDDN6NjKDglDr+KjSoCrA8b8yc
	 o41GL4+1upV4gjlyYXaLr1u8sozZn2UxQ1HyAr1K/lBhT+UlIjuEpZaMLbZzXC8KpQDHx
	 kWkwM78bxuPu1cNEN2nGmgm9pnJh4Plk4mPCzWuMbBEo7z2xDtfQDovENAv6WbHUMOOF6
	 FUOS1pZXWZ2HVnF+tgCz16pll8ulU6rxSf0kV8KODLeif7T0X2vQ5jHP0KEf1ciUtfNEQ
	 U3MFkLoMsgzyfJhOh4DoV4quQHvP2Nz99kzwE5ad3xL0fbP+aHgzTOUc1GFbix+gsVQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793890690;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
	 X-Developer-Key;
	bh=dkHDrNCnxbRAmnY9iwWb/71MER1I0aFyaj7MSqBXhvU=;
	b=wUWE8KSskOOZgLhZ/5JYlS2895fhuyVi9i90HY/fG/gAt2bbI4xHYeb36B0vYRqSXsav
	 XjjRqRFq6cDJVoTEoOVsDALdLicZ8UGoI85RpdfAzp/oO6aXAAmX7EnQeRJ3VrdT/rsQo
	 DARW7Nx9Cl4Vf939/2wEZeFCAGU1C323AqDnCcYHLHZyyXIw0G/hDZ/hQ/iQnuvwCZWWV
	 1BUwBcHttsZwOBCw8rdgCpjZFVS0QyhppA0YJ/aSG1KGuGw1ER9hCY9CWuGqS2PBHNbIy
	 gip/3hBYtRiLHQrZ6WF1zwpPE2aZEjMhyUcrS4dm/OqS3K1hbNbIitDWtlMMFY2f+VQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=toxicpanda.com;
	spf=pass smtp.mailfrom=toxicpanda.com;
	dkim=pass header.d=toxicpanda.com header.i=@toxicpanda.com header.a=rsa-sha256 header.s=google header.b=maL75qis;
	arc=none smtp.remote-ip=209.85.160.50
Received: from mail-oa1-f50.google.com (mail-oa1-f50.google.com [209.85.160.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9832606EE9F
	for <linux-fsdevel@vger.kernel.org>; Thu,  5 Nov 2026 14:58:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C9832606EE9F
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=toxicpanda.com header.i=@toxicpanda.com header.a=rsa-sha256 header.s=google header.b=maL75qis
Received: by mail-oa1-f50.google.com with SMTP id 586e51a60fabf-48ed0b68895so1187592fac.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 05 Nov 2026 06:58:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda.com; s=google; t=1793890689; x=1794495489; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=dkHDrNCnxbRAmnY9iwWb/71MER1I0aFyaj7MSqBXhvU=;
        b=maL75qisbSg7A6ZT1QyVY069cHhEGhEKq4v5K5iAIKr5opdzCVaakFSh2Cl7rWv7I9
         vZc+7MEMQXFRvvo17Sa1qPJtfTiQ9xx4k355LxGHnrYoHOEzzZf/IvnBXGjqL7JmhAkz
         wR5cc1UbDiYhshFlVhGut5m7ynVrGcP7zbX8LxsX+efWcQouN5cnN127Z528JqW1XqmA
         WcZqFKY7LD4Ojm4B/kK08gK4uheI2csK9t9EVM5Qy+NJF8MmE0QElidvM8s4xt02wEpr
         4QQU1qAp9QjKUUoMkq+4Gd5MZOGlC/lccXrtaWwrhInaAl+rfTBS6DWHLBLsaKagq/m8
         p2Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793890689; x=1794495489;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=dkHDrNCnxbRAmnY9iwWb/71MER1I0aFyaj7MSqBXhvU=;
        b=LPfIwWHVko305vqcie2mZ1pUA647e6FHbuPt8Cbms/dhON87QKDvDdFn8sdZWnc7K9
         +1qi/C/B9QKddXHqdaVGpoaP/VIDPFRUdW//tfiHVoMp/6m64A90QIrJSOI+qg9ZYGdq
         /2YN7nxVz4ylYlbHl+ZNIhCtHGB2+HXyM2Gw+svZMXGuWxF0s/jSOfk4LmJJGcIO+ras
         oKTik6yeZ1dGvW0QDkn1IorfGNcPstEspdDZn76kA3L3FjUwjee4OXqSSHMJoRjAgFt1
         XXUZM6S2KqqJ3vDS/AwLbmAyWe89zbrLfqKbSd9PBozGgnj23QbpjeQqNfE08YhWZsFc
         4zcQ==
X-Gm-Message-State: APuU4Z8bUM7hecYTiCM1rcUDq37yTxs9LLmdelYmvx7vdgCT7/B0cpI9
	wyCdzGodXAO2kS4l4MVT2zgE74bt/i1qVklQTFrVxPundVbArlGUKydyC1TD2QALgFCqXSkBGdT
	WCvXdk28=
X-Gm-Gg: AYBFou24TnsFkIy4zNZvswlatarHR70Hn19fdhcvCjoCNMnwN+e0vN7nX9gET6zOrW2
	1Ui+GyiVoAKl1cDhkHE7Mo9YS+r/6FeSJ6lXXpR8h1G2nz3/8vTBbCZqsDkbVUNniBoBarA3NKe
	6xtJ5QucQFezcda89uBIz15oNR54/mzWRYhGNd59ZxcwNl/f4pNuKlupN3Y8EY8GKAvY+JLAOs4
	lreVffTuM0pLqHxM+Ljf68YaM6F69iKQxDXogziPtQXuGl/Io4FitG1ENVffSRxtrLgAOuj64tY
	3ajV/IY4IjJnGvCQKcJiUVCna5t+I7NPZKjN6A4hOMPASTzeKjgE6rYcwkUQRcR2Mtiy5AfTBN3
	mGdJ2pVPr0UWyByfyRzEc5M1Ouymb8f+D2+H1PgItaRrmKR4S2IX56bWdRHpIu6/Ka2XCemW9iN
	nHGRwgTCrSW5WqAdOJJB15R+BiQuZ9IbHlJAaq4H78sY3BglHQqPlwet0Bjq9CKM82tZRa1J/EX
	TK1oN7sS8pRkPykHRcBZAcRMZi7vTyfkp81VzrJ3rwy+qQBMMxdI2exYoykHEH5JOApKrvyaYqn
	Oe2Wwhwd0NXGD6RRA3/61h0YemkpQZvUxtgJGp/hK8DazQ==
X-Received: by 2002:a05:6870:b510:b0:483:67d7:e045 with SMTP id 586e51a60fabf-4a90761be6fmr12829444fac.17.1793890688649;
        Thu, 05 Nov 2026 06:58:08 -0800 (PST)
Received: from toxicpanda.com ([153.61.196.251])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4acea680cacsm4490943fac.16.2026.11.05.06.58.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2026 06:58:07 -0800 (PST)
From: Josef Bacik <josef@toxicpanda.com>
Date: Thu, 05 Nov 2026 14:56:58 +0000
Subject: [PATCH RFC v3 07/90] ucount: count the id blocks a user holds
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261105-b4-cells-v3-7-bc9095937a84@toxicpanda.com>
References: <20261105-b4-cells-v3-0-bc9095937a84@toxicpanda.com>
In-Reply-To: <20261105-b4-cells-v3-0-bc9095937a84@toxicpanda.com>
To: Christian Brauner <brauner@kernel.org>, 
 James Bottomley <James.Bottomley@HansenPartnership.com>, 
 Andrew Halaney <andrew@amutable.com>, Jeremy Bingham <jbingham@gmail.com>, 
 Tahera Fahimi <taherafahimi@linux.microsoft.com>, 
 Serge Hallyn <sergeh@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Josef Bacik <josef@toxicpanda.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openssh-sha256; t=1793890669; l=1206;
 i=josef@toxicpanda.com; h=from:subject:message-id;
 bh=nNOYagXPS7UuclEa6CcqzF+lG9K1DgR6fFtMR2Grrjc=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgUBr36M/n0nWN0DNbnxwzIiCZez6MG
 JiruuNaSCI/zXsAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QIMu8+xlcTKBuamFsS4d1TuvaQKBaizx5lSbbA0HZfVJWo4o7PZbAa8Z4P+CWt1buiOR2uGpoPQ
 UEHhTUD2aMgk=
X-Developer-Key: i=josef@toxicpanda.com; a=openssh;
 fpr=SHA256:C8kOX2QUJCMqnCX+KEeoqRAjLo9L+ELOSH2NSAJHqGA

A block of ids gives access to nothing, so taking one requires no
privilege. But the number of blocks is limited.

Add a ucount, user.max_cell_id_blocks, so that a single user cannot use up
the window.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 include/linux/user_namespace.h | 3 +++
 kernel/ucount.c                | 3 +++
 2 files changed, 6 insertions(+)

diff --git a/include/linux/user_namespace.h b/include/linux/user_namespace.h
index 5c8cf31ab9d4..f0b0fe12c2fd 100644
--- a/include/linux/user_namespace.h
+++ b/include/linux/user_namespace.h
@@ -61,6 +61,9 @@ enum ucount_type {
 #endif
 #if IS_ENABLED(CONFIG_BINFMT_MISC)
 	UCOUNT_BINFMT_MISC_INTERPRETERS,
+#endif
+#ifdef CONFIG_CELLS
+	UCOUNT_CELL_ID_BLOCKS,
 #endif
 	UCOUNT_COUNTS,
 };
diff --git a/kernel/ucount.c b/kernel/ucount.c
index 94b70502dc9d..7eab985121f6 100644
--- a/kernel/ucount.c
+++ b/kernel/ucount.c
@@ -93,6 +93,9 @@ static const struct ctl_table user_table[] = {
 #if IS_ENABLED(CONFIG_BINFMT_MISC)
 	UCOUNT_ENTRY("max_binfmt_misc_interpreters"),
 #endif
+#ifdef CONFIG_CELLS
+	UCOUNT_ENTRY("max_cell_id_blocks"),
+#endif
 };
 #endif /* CONFIG_SYSCTL */
 

-- 
2.55.0

