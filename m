Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CD373E92B7
	for <linux-fsdevel@vger.kernel.org>; Thu, 18 Jun 2026 10:12:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781777585; cv=none; b=Vf9LvHj7jRwLjgmmHNlcqbB6mIclyQsVgzaz+VR8g2kx6RBKCIA5S04ufZsH0nbdBuo5uqAqLT6BGD5P5XUVUI4fw8y3008TmC1r4jKKtyg5zhZ2j22SaQ3cuIODbEmKir11BUYEh20FMYfucVdeOinrGIWMTIQDriB0RoRwEow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781777585; c=relaxed/simple;
	bh=Ek8NQg1KPtSH0kD/SJcZzwssAOfa4BS/6ucq88mx4y4=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=ZNDk85Q4Ci1SxyT+sX+xbbZcZ3oOU1NJZXqf9S1W016jeZidzXg6F3MwMjRusxq3VyQbJdQo9K6wTIHj6D4wJHJIbFNIStV/GSeBpMfTf2UemzOD55k9TsSL+B/97xIulrZmvqnOKvNvVOrc+RSe1XUjhTR/BA6xPAr60270ZVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ShjPg6Ks; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=cfhyW5ix; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ShjPg6Ks";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="cfhyW5ix"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1781777576;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=bVeLhPgXkRL9YuY380vyxTPxAt6EUze1B3shKhUzapA=;
	b=ShjPg6KsMiMXt6O5BY1uNOf3GG8xu8WU/Fh+FHPljJrBL1fsvMxnIR6JGA7PTWDkJAVAa7
	7K3vqZK11K0njxHndj39UhTmbHh+2imHcNXH9eS6PXgTK+jTrhMSdMDH9+9+SQ3DBF1106
	Qat6CzmvgVQTI9+a/5DJPBpKl6n8Yig=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-45-v_qk_fKTPSKqnuE8RsrDHA-1; Thu, 18 Jun 2026 06:12:54 -0400
X-MC-Unique: v_qk_fKTPSKqnuE8RsrDHA-1
X-Mimecast-MFC-AGG-ID: v_qk_fKTPSKqnuE8RsrDHA_1781777573
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4923411f041so5594985e9.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 18 Jun 2026 03:12:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1781777573; x=1782382373; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=bVeLhPgXkRL9YuY380vyxTPxAt6EUze1B3shKhUzapA=;
        b=cfhyW5ix5o57TlKMhoSH8KdPN9lqEBauSeh2XPQgb9AXfYEWYm7pKFtcUV3d5U1DKx
         +rMDwoshVgmWMNK77WnhudylwSBczToWrW1j1ynAb7W5kHp9/aAM75GUwpzTf5nxlbQ9
         9wrXix0vfBKesct+xuWxOaLZwBJEd0BL3MDDyIBtzHORez/z7xIwQzgjbRdl6Cv6guxh
         k6jsQbg7DRsEaRn1m3SuLVXyu9nJucD6VceYJns36SLLtvteTppB06F9hjkUwrb5caS+
         xjyHSMyo4657Xf/nx5GjruqB/X080GUTEtwGFabnSBB1hLiMZJdNU5Ctj9+71rGK+Dt7
         jhig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781777573; x=1782382373;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bVeLhPgXkRL9YuY380vyxTPxAt6EUze1B3shKhUzapA=;
        b=oCAsN8XURCh61sJQd4sQloaDIXSmbCIpUrFWckZWB2voErVeS4T24CQx+a2XTe7MMJ
         sf/JJdFCJSijr27Odw6V4hjQ00QxYmtLgmcLqfyZzKL1IhPkXhfVIpUJKps6Gj+SsOOR
         tFp4+MYV1Yq8hCzu/PKlP3lXAiCSbIeC/pk/vrK9dqwOYENMAhuTQgBQEXB2M+cGXezm
         63RLquYWlRYgWQF1ckTSHvHpLWxtZc6KDMSBcH/knNXjUssgfuixYqeBz2/K0aTrwZ5h
         J4v2FgsDbCRSeuiEQWnj7pXcoCR7J5mfnLdBnqjSckVI2H7OBBa6GAvP099j5VA7bKas
         FYVA==
X-Forwarded-Encrypted: i=1; AFNElJ8iFyNdeJjMvZuFyV0dm2iW+ZufG0IijrSidfokG7ZGiUmeGQ24umMbXeLxdWuaHC+SaqsYTQ+dXeXKko5F@vger.kernel.org
X-Gm-Message-State: AOJu0YzFemyw3p3ujdmvnblqTwhkybT3kgTmepQz1xWmP4aFTn7lbDae
	R5XYZ9sq89qzY/jsbzsDVtoeVrMUdQHEoA+wonEWZDVJdm6Yc6otuKS40TExLHXwntmKTF9iGks
	J1feXC3KIPlP0HAu19r6jMzD7/R78cIUZv5F/epr5n+6STqgaICci7uz0TyUnVb5sC72BTHeQ0b
	o=
X-Gm-Gg: AfdE7cn+3pCBuQEmNSQLYxOHzSdSA1bzIYPG6g8OidR4mH3PMkOOKfG0cKFs87J94qB
	aLBOqOU0kyBTYyzCZJ6Xpu2869lfrm9r5ginaLXZMrI6quwbQNSx6I53YDV3E/2GRf6hvz4ETCA
	eVNPgjKXIH4BIoqPvFYAumnn+CJhiVGijcP8GwIYWLe+0+rFKGA16W2rN0+bMsVFq2gZOP2VVi1
	ZH5S1VTjhclp4C2IkPPxZx/Uk/1axJuVK7THKwLS+Pr1Xv5K5Gk67ARbpl92JDON6m6l+0yQhLO
	XF7TeFgitiau3Zt32Ocy6bgz3ZJ7UdhriwZ1BKOmhfT1s13iIXiBtJqbrsbG022FoJ9PFlYcxU1
	Pbg4x5YXhGAmrpwDAJQTZN0UxcguZBdrvOn9lTd2OynE=
X-Received: by 2002:a05:600c:1d12:b0:48a:f18:ece4 with SMTP id 5b1f17b1804b1-49238226374mr47726085e9.24.1781777573076;
        Thu, 18 Jun 2026 03:12:53 -0700 (PDT)
X-Received: by 2002:a05:600c:1d12:b0:48a:f18:ece4 with SMTP id 5b1f17b1804b1-49238226374mr47725485e9.24.1781777572613;
        Thu, 18 Jun 2026 03:12:52 -0700 (PDT)
Received: from 192.168.1.130 (cm-93-156-201-22.telecable.es. [93.156.201.22])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49230a96d14sm216388815e9.12.2026.06.18.03.12.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jun 2026 03:12:52 -0700 (PDT)
From: German Maglione <gmaglione@redhat.com>
Subject: [PATCH 0/2] vfstest: fix tcore_acls() cleanup bug and missing
 _require_acls
Date: Thu, 18 Jun 2026 12:11:52 +0200
Message-Id: <20260618-xfstests-tcore-acls-fixes-v1-0-45a1aec1d99d@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAGjEM2oC/x3LQQqAIBBA0avErBtQoaG6SrQQG2sgKhyJQLp70
 vLx+QWUk7DC2BRIfIvKeVTYtoGw+WNllKUanHFkyPb4RM2sWTGHMzH6sCtGeViRFtt5GihS56D
 +V+I/1H2a3/cDVquZmGsAAAA=
X-Change-ID: 20260618-xfstests-tcore-acls-fixes-6d15a696f652
To: fstests@vger.kernel.org
Cc: German Maglione <gmaglione@redhat.com>, brauner@kernel.org, 
 linux-fsdevel@vger.kernel.org, zlang@kernel.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1781777571; l=925;
 i=gmaglione@redhat.com; s=20260618; h=from:subject:message-id;
 bh=Ek8NQg1KPtSH0kD/SJcZzwssAOfa4BS/6ucq88mx4y4=;
 b=dQYQZ/QUachk/547w9dv7+oO3MVvDJABHn6RGE6Zd9kz5wz7kSZCpP+pCvICaU7fucbvMfO0s
 w5MqBCSgka3DG74/l6o3vKwas2VnbNXf9Y7lJuKFjQxAhGCRaBaiOBV
X-Developer-Key: i=gmaglione@redhat.com; a=ed25519;
 pk=EgoGsSGnVamWcruH9kiHxwzZf0dPTHHxIjd1Gigd+yo=

Hi,

Running xfstests over virtiofs I hit failures in generic/633, 644,
645, 656 and 696. Two issues in tcore_acls():

1) sys_umount2() only runs on the success path. When setfacl fails,
   the mount is left behind and every test after that fails with
   EEXIST.

2) generic/633 doesn't declare _require_acls, so it fails instead
   of being skipped on filesystems without ACL support.

Signed-off-by: German Maglione <gmaglione@redhat.com>
---
German Maglione (2):
      vfstest: move sys_umount2() to cleanup path in tcore_acls()
      generic/633: add _require_acls for tcore_acls() ACL dependency

 src/vfs/idmapped-mounts.c | 5 ++---
 tests/generic/633         | 1 +
 2 files changed, 3 insertions(+), 3 deletions(-)
---
base-commit: cac9fe2b8dc3e6dbc0c2383b9e3b4d3c1b9e7dd0
change-id: 20260618-xfstests-tcore-acls-fixes-6d15a696f652

Best regards,
-- 
German Maglione <gmaglione@redhat.com>

