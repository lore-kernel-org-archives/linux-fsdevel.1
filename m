Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793890706;
	b=uDa4bF2NMDvNf2DH9kO1gXnM4HFhL7aWmu9PlikUvQx81vrZpfpp+3U2pK6qnpzejzYo
	 1n8jYqLg8Gi1cg4t2DU8SgxTmiTufB5mEBJZRO8U3UwtXH8xBG2poObO52CEbDBgltNp9
	 bt9OPd+zF6QWNqRi1MqraGWXAjEemTzPRuYe//rBUqPGzhHKf18VkezS+p5OfMMcUHGYr
	 +R1R8878bXQnt+SzV7VfMHmN02Uy+pQVilDydzQzYMjVthzEX6JpH3mjhjc6eZrX0QPF6
	 nxz4knlbuDJdk7UGG42aBa/8ds8qgVJKP3lGedRYtW1kdF60Naw2iwglVgcXkwvk8lw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793890706;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
	 X-Developer-Key;
	bh=2nslQvC/aVHnWdIM3Z4G4/15txf2h77Oj9uqNFdqD0I=;
	b=DNwoorHG1NFN9jZVMqblsWVucNezdT8xtvx0xCI3dVR16naAwSr+Dxe5q1QamZMcieWP
	 RGhkPK7w8otYtnNmfGTMQe8Pd/IEk1w5TN4sUbzAEY/8TprIPM8p+GVpt/zwg+CUTSVtH
	 3pO8yNFI9/2YUrI16lBgVQCVOfbHsDtA5paF411M/llpwKbQiMWgS+PDHMLsXkTf3P4vW
	 XlmYU2eyR6+bfhFAhGTjxtligDls/YDcrsx3458ZcUXplYOHiPQQVpSrpD9FvA6Js/8Cv
	 BkkQyw8wtlOFgrVT1pUcla55ewzyjhvfIgJj1Dq0EZILWmTS14FsAP2BomPnJNJwnXg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=toxicpanda.com;
	spf=pass smtp.mailfrom=toxicpanda.com;
	dkim=pass header.d=toxicpanda.com header.i=@toxicpanda.com header.a=rsa-sha256 header.s=google header.b=OjG4onLT;
	arc=none smtp.remote-ip=209.85.210.42
Received: from mail-ot1-f42.google.com (mail-ot1-f42.google.com [209.85.210.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53A57606EE9E
	for <linux-fsdevel@vger.kernel.org>; Thu,  5 Nov 2026 14:58:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 53A57606EE9E
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=toxicpanda.com header.i=@toxicpanda.com header.a=rsa-sha256 header.s=google header.b=OjG4onLT
Received: by mail-ot1-f42.google.com with SMTP id 46e09a7af769-8490a7d6696so1233101a34.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 05 Nov 2026 06:58:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda.com; s=google; t=1793890705; x=1794495505; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=2nslQvC/aVHnWdIM3Z4G4/15txf2h77Oj9uqNFdqD0I=;
        b=OjG4onLTyO9/HeWu2wWrKpIlBgalaUbSg1aE8cDuWWJKH2+2YcCmfYNv0Ilp8T/mWO
         l7W+Y1w+bb90O/WEIwazfUTxIuBgTzkUGZyP4yp5ZFp83GmZZRI5VttMl2QyXeMA9eDk
         gcBlMNfM9KTR/ieWpT9Th23oXinpOI2jWIucbHNEQAHQJflGN9/q61RpmZZ2dpVGzlWe
         TX4I9vaVohguCAftJewTlwT0dJO4TI4SarTFKR0uZ8lgtyGJvo9R0FHmDmgu8aOZwEaR
         G9D+s/70lZof4PFw1B1NONGqP35dfDKMHXzsnWgRrYHeb3YVw4/uCL2RcYJJ5pi8iEoQ
         suAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793890705; x=1794495505;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=2nslQvC/aVHnWdIM3Z4G4/15txf2h77Oj9uqNFdqD0I=;
        b=IV/CbV4Ws2XeCZ//I8Zh7/UvK5NNzqTnMH6TL9fGGfv2+LTcKTFOAEe3F8v+G7YmUb
         WfmLJTDuGJ2jlWQcB3JYPAyKaOzXBbzidHJygvGMsSWnpu+IphQnFofuGNOCBTFTm9Ow
         J74AhTsIkJ1P/a7iDWxFxTNhqPE3fPQLjCUsj30qaB9qhAZKv+R64zvU31XXZ5Lverps
         TWohB9VeWzdcrwNqinBAXIi8qcfvQH1UqsJzbT08BW/s1nxxedjGuCyc3/5JBiz+UrLr
         DSvRncaznbHOZjEIObpEar0psNCsvM6SK2z7OoijA6Ftgg86ul0wkkVjmrTOLyUP8f/D
         DQXg==
X-Gm-Message-State: APuU4Z9bGffU/ppoAdOXz4G9zu2omCYb0XZIRz3wf2W9lfoL3IHr3kDP
	cPMUBajLFYpSx4399OjUMniWPHdTgqQ++E2qhzMTQhbgkM9IP7gjufMP/rZW5/Uxf4Y=
X-Gm-Gg: AYBFou2HLnRjyT/UPojP2Kzu8VTE4Rc/EIadun0BchPiQLR6SU5vdewMcIvJTLo48qc
	JRJYyWp+iV6CoufAKacKmQAl5EiuG38lmVO3oDIHjUnSa6Imasx4sTWD79EHeSBfxEWpY9xqv1z
	vjusQldfvANEOQeCdKBdEMJnX3prv/5efzbIN1s01KiCoh5ZapLFpFMAv7ghWD6Vf4XAxzUmcZV
	yn5YIwTtayFjsCMfbtbiV8eXAvPsjFrFCvW0UfV81Cnoj5UAJNeAgKwKO5aAqfbD531B16nXsBJ
	UdNhUauHfTDZUnDQOlxCzoir21TDg5vwOqu/feDpbClC8pXixZv17S4N1k9e8XihR9J6ly9BnWs
	VA/b53ADScvEv6fqP+D0l1NoZuZNomrZ5IfXoGcgusADMFP2+wxKOtzCDln94LsfI5k+Zc2zEPm
	cd/bohHrcMXgZjryZURuVEQAMB2GYmKmVlUJegJYNDieYlnbpewp6EI08Xl2Q3NkXd69oE+WGel
	Boaic93AWUeFtHyNTFcAEsAFBOpl6A4usoyOEn0Q8USoLMpdYI1Aaukcq20EF9Zu/I+d7wpW9G9
	f/9tpXr9EyQZB7NWcO81V4PKmzo+uriXdsmnzlotxZywDA==
X-Received: by 2002:a05:6808:1798:b0:4f4:b62c:a3d8 with SMTP id 5614622812f47-5640dcc0142mr13239065b6e.33.1793890705297;
        Thu, 05 Nov 2026 06:58:25 -0800 (PST)
Received: from toxicpanda.com ([153.61.196.251])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-567a9f34acbsm4419244b6e.7.2026.11.05.06.58.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2026 06:58:23 -0800 (PST)
From: Josef Bacik <josef@toxicpanda.com>
Date: Thu, 05 Nov 2026 14:57:06 +0000
Subject: [PATCH RFC v3 15/90] fs: let an idmapping pin the ids of a cell
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
Message-Id: <20261105-b4-cells-v3-15-bc9095937a84@toxicpanda.com>
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
X-Developer-Signature: v=1; a=openssh-sha256; t=1793890670; l=1943;
 i=josef@toxicpanda.com; h=from:subject:message-id;
 bh=LEm7jnZkkI0mYjYi1LA7l2MoWWec+D2ZoGJVtMUTiwE=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgUBr36M/n0nWN0DNbnxwzIiCZez6MG
 JiruuNaSCI/zXsAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QGBAr7sDJpJH2aFRSBZBN348qhOGfAgviJxZyIAOk4k8MK5LiEamnB164r4rMbVuLGjKA1h5/fr
 qPx5HzTh/6gE=
X-Developer-Key: i=josef@toxicpanda.com; a=openssh;
 fpr=SHA256:C8kOX2QUJCMqnCX+KEeoqRAjLo9L+ELOSH2NSAJHqGA

A struct mnt_idmap holds a copy of the id maps of the user namespace it
was created from. The copy does not pin the namespace.

So a mount that was idmapped for a cell can outlive the cell. It would
keep translating on-disk ids into the ids of the block after the block has
been lent to another cell. A set-uid file on that mount would then run as
the root of the new cell.

Let an idmapping that was created from the user namespace of a cell hold a
reference on that namespace. The block is released when the namespace is
freed, so it cannot be lent again while such a mount exists.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/mnt_idmapping.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/fs/mnt_idmapping.c b/fs/mnt_idmapping.c
index bed57094cef0..93a34bc93efd 100644
--- a/fs/mnt_idmapping.c
+++ b/fs/mnt_idmapping.c
@@ -21,6 +21,14 @@ struct mnt_idmap {
 	struct uid_gid_map uid_map;
 	struct uid_gid_map gid_map;
 	refcount_t count;
+#ifdef CONFIG_CELLS
+	/*
+	 * The maps are a copy, and a copy pins nothing. The ids of a cell are
+	 * only lent to it, until its user namespace is freed, so an idmapping
+	 * that names them holds on to that.
+	 */
+	struct user_namespace *cell_ns;
+#endif
 };
 
 /*
@@ -281,6 +289,9 @@ static void free_mnt_idmap(struct mnt_idmap *idmap)
 		kfree(idmap->gid_map.forward);
 		kfree(idmap->gid_map.reverse);
 	}
+#ifdef CONFIG_CELLS
+	put_user_ns(idmap->cell_ns);
+#endif
 	kfree(idmap);
 }
 
@@ -294,6 +305,10 @@ struct mnt_idmap *alloc_mnt_idmap(struct user_namespace *mnt_userns)
 		return ERR_PTR(-ENOMEM);
 
 	refcount_set(&idmap->count, 1);
+#ifdef CONFIG_CELLS
+	if (userns_is_cell(mnt_userns))
+		idmap->cell_ns = get_user_ns(mnt_userns);
+#endif
 	ret = copy_mnt_idmap(&mnt_userns->uid_map, &idmap->uid_map);
 	if (!ret)
 		ret = copy_mnt_idmap(&mnt_userns->gid_map, &idmap->gid_map);

-- 
2.55.0

