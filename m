Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 982B238DC68
	for <linux-fsdevel@vger.kernel.org>; Fri,  4 Sep 2026 14:28:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788532101; cv=none; b=U4djgBex11MNO7JyY7YJqWC4v7XiEd5g4VAjNyXOHGJFCX0Hm0N5NnItw9Z35hWkvhJTKdMmU7+mSV9ZGmqEzaWAIJK4teE1Sro8+eJBCcUwj3MqjmLWX5nlL4phMXzqTi8f/HrgjNti4mupBkpKeiZ0NisOce/GXEl/hOSlC2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788532101; c=relaxed/simple;
	bh=kf/1ey0GqeVu9fPQWj2L2Mm5Rt20DZ2y/xGWZmN2GIQ=;
	h=From:Content-Type:Mime-Version:Subject:Message-Id:Date:Cc:To; b=CB7D7X6rRAMrZXHK/FsqJAQe9G3vWIr2fZrf8QK88DMCnaYn8qucMVXb/XV/9lINKRkO8DVf12hALisBms76GrXPjLV4kfPi7REQfDYqvz54k92VaE5jJXaQR88FUHSpj+AqsYjG8AQE0FIwRodUVnOivMGcWJWMNOcGorLc63M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=doyensec.com; spf=pass smtp.mailfrom=doyensec.com; dkim=pass (2048-bit key) header.d=doyensec.com header.i=@doyensec.com header.b=e4h2L2E4; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=doyensec.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=doyensec.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=doyensec.com header.i=@doyensec.com header.b="e4h2L2E4"
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-c15cf78d1a2so102364266b.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 04 Sep 2026 07:28:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=doyensec.com; s=google; t=1788532098; x=1789136898; darn=vger.kernel.org;
        h=to:cc:date:message-id:subject:mime-version
         :content-transfer-encoding:content-type:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=NNlQHxyERxR0BCf4rdmfxT/+3TEDXoy4SOv/36YNyCQ=;
        b=e4h2L2E4sNxwcg/rMrmYH4uyGNjbaU1O9UWm2Ubpi5HR9o23N+3u7u3hk0VSVPkUNT
         2wKfIzEz5fPVA/A4DMesB6ckAB7y7ZzhHw/mJVXoxLk08wIAtQJGXw2EY8zinrFnD148
         nD2FoyVHh6T/h7lvr3UFdJNZEkeZWA0gSoIrZ9vLj3DnERth4R23wa1rcjo7CtZXywIC
         LritYKRA9Uzu6i7JyS5wO71eN0JxfqTA5/het6r8uScBN+NY9x5Eu98zL0aAdxYnspYZ
         gkpM21l9v1t8kyCMCoZl2q95ajD+uPeTckAzlEGy9tTVwG+907+IctrBYgIyeJAxbeDc
         AbGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788532098; x=1789136898;
        h=to:cc:date:message-id:subject:mime-version
         :content-transfer-encoding:content-type:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=NNlQHxyERxR0BCf4rdmfxT/+3TEDXoy4SOv/36YNyCQ=;
        b=mGY/KwBNsMVtwRBihi9WuUJhuwFv2fKDL6rHPGmrXIh6eFhDNZ41j0YBHp/QWdlmEC
         aT0OtoHnbW8uWaMIFb5v91F3vjrMUoP09tbaQI4Tde4QX2jWBnyxwyLDPlEfy4jlVxdw
         5j/VardJ97ybBooMQ+RYaYxBc+o50jFhSpmFnR6HmHF6+KRT8pJvmQCszSlQBwvAm+vl
         M3VHBruAFhOqqECDmH+/vZjnHpsCY4A0JJAi9/B6EOAlzI936aE0qnltOMoqWIOLWs6p
         W9C6KiQoJFiNy85KjMQSA8/4ST95LQKP2FQPhRcNRmSRkRBJf0TLzR+Ko59cXIK6O4VM
         Jb3A==
X-Forwarded-Encrypted: i=1; AKwUvBwyyaOcPfXw+/9RaGQ/k85kNiWpC2QAA5m1lU90Tc8aATRQfwT5tyWF1I3PsvpkxRr9tkMFC8Jc+RU9EetU@vger.kernel.org
X-Gm-Message-State: AFuF++mQznoVW5c4Hw29Y74lB9E6uDRwTUe/IFtZaxBCuPE4+RzsxXU3
	ciIxPkEMY5gQhK4wyY129q1QBHZ2vqNX1WP0STvAdCMJe4t+2hgpHhvnT/0ujyVFMbs=
X-Gm-Gg: AYBFou1SDjl55TD28HPMVxbnsVpYRCz7NU4C72yStXC4Yl++UygA/YxYIhKi1RNYhaV
	JDdNxVS9wL9x0nm/4VUYF2xJiMZTjPNVIp5GHNckjMQ3qckyigL3YLyxG0XI4hskUiV/Is2p9Ff
	fdlBD/m0Alim3ymmKIPY8Ex7qgF06PTloqvKWozTc2+WSWXhkggicdK4+Cv9O8+A+/AHH3X36SU
	AOnlu0yxUzlvQw5vOW+Vt2botP5/zGIFFRxfdIfUkc4u+ZtMPoLYEepPQdohjxm9XyQsY/G4YlB
	kyzsnYOh24jOq8KU/ofvVhU41oGq/db6WsTveJ1fBDa95aj3KqRavAD0ebJW7iDAs01olJOntHF
	6pxrgILHGIksSZQ96nuTWOlcQWkkXopL8nMJKLULvHu7jq8QGcRK/np5eps5rZeb5bVF5Xk4ybS
	Jy5XPSG/28xWXrzP8ychCiQfdvVi9n9hON55/9XPR8FJnp5ni/ELPAtRZjqJm5nlDjkgtFcWz20
	dziLabVo7j8PEmIGP7AlNFJuTxrLnlFa5ps8CC3HelRJaxTT/H/lrs=
X-Received: by 2002:a17:907:728f:b0:c26:19e3:e97a with SMTP id a640c23a62f3a-c2619e3ee84mr151939166b.26.1788532097705;
        Fri, 04 Sep 2026 07:28:17 -0700 (PDT)
Received: from smtpclient.apple (83.10.35.35.ipv4.supernova.orange.pl. [83.10.35.35])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c260d4aa01dsm114864866b.15.2026.09.04.07.28.16
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 04 Sep 2026 07:28:17 -0700 (PDT)
From: Norbert Szetei <norbert@doyensec.com>
Content-Type: text/plain;
	charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.700.81.1.4\))
Subject: [PATCH] nstree: check listing permission before taking a namespace
 reference
Message-Id: <34C54FF6-AA8F-4124-9B40-C68EADB26D99@doyensec.com>
Date: Fri, 4 Sep 2026 16:28:05 +0200
Cc: linux-kernel@vger.kernel.org,
 linux-fsdevel@vger.kernel.org
To: Christian Brauner <brauner@kernel.org>
X-Mailer: Apple Mail (2.3826.700.81.1.4)

legitimize_ns() takes a reference on the candidate namespace before
may_list_ns() has decided whether the caller may see it. The
__free(ns_put) cleanup on the denied path can drop the last reference to =
a
mount namespace while we still hold the rcu read lock, and put_mnt_ns()
may sleep there. This is the same problem commit 2ec2aff3c8e2 ("ns: make
sure reference are dropped outside of rcu lock") fixed for the =
put_user()
path. Neither ns_requested() nor may_list_ns() needs a reference, both
only look at the namespace type and at the caller's own namespaces, so =
do
the checks first and take the reference last.

Fixes: 76b6f5dfb3fd ("nstree: add listns()")
Signed-off-by: Norbert Szetei <norbert@doyensec.com>
---
A reproducer is available on request.

 kernel/nstree.c | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/kernel/nstree.c b/kernel/nstree.c
index 6d12e5900ac0..831f279d174a 100644
--- a/kernel/nstree.c
+++ b/kernel/nstree.c
@@ -533,19 +533,13 @@ DEFINE_FREE(ns_put, struct ns_common *, if =
(!IS_ERR_OR_NULL(_T)) ns_put(_T))
 static inline struct ns_common *__must_check legitimize_ns(const struct =
klistns *kls,
 							   struct =
ns_common *candidate)
 {
-	struct ns_common *ns __free(ns_put) =3D NULL;
-
 	if (!ns_requested(kls, candidate))
 		return NULL;
=20
-	ns =3D ns_get_unless_inactive(candidate);
-	if (!ns)
-		return NULL;
-
-	if (!may_list_ns(kls, ns))
+	if (!may_list_ns(kls, candidate))
 		return NULL;
=20
-	return no_free_ptr(ns);
+	return ns_get_unless_inactive(candidate);
 }
=20
 static ssize_t do_listns_userns(struct klistns *kls)
--=20
2.55.0

