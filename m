Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AE67317176
	for <linux-fsdevel@vger.kernel.org>; Tue,  5 May 2026 11:13:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777979584; cv=none; b=nposz/zyEsaWZ56SuRowrZ3cIJ/dus7xPm5PHuK085T/U8WZUpZ+yv47z6vIBUgpvPrx/E9OfCQhOUALpkVByDKdBRbsPCeE/szTirXExegMbbE+a/4nbFLijr1oiZxoRlSwMAN3k2irGbpv7CBUfmwrzmwgcZkz6QyIf+NveFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777979584; c=relaxed/simple;
	bh=tmvCtlp0eyhFLEflds47ofyuT+XxyEncoia9jdG4v0k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MqcwEwJq5uApz57TjE3LZAN4z8dHYIlyv+TJ1CRQ7RndpfmMO75AMRETdMFmukSL6JEYB2HbXzu5YILCY1Jdo6owDpZBZMnbjB5ls3klbC4W4fLTotEFWNKa0KKaUwoZQ/BVk9YyzCxv38t6T61R8/aZJf50n69+GtjPAhdVfbw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TAI8om/9; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TAI8om/9"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-48896199cbaso45347785e9.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 05 May 2026 04:13:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777979581; x=1778584381; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dzDOKNU0TaHsfyv5XbUdLHd2w3+qHipKrsIES1vuEME=;
        b=TAI8om/9KODV2OrIHYEaciKlYElkChGOfbd9t9APbSlur/dn3Q51BIsgctUhOS9HWL
         kQmprrOolQK6HCWQqCKNiV+L9IXN4+zUP/j6jhfc/9u0ZRy7OOVw5eay8hxGu6jtjILS
         OG3okpCMCLIspXSxvFLuaTz8ts22/+2cydDJIvyD/SzNxXwlWgkt69gWQCTT4qg4TKm9
         OhGzXW0p3RwrHug4JmzPhXVjWDlJCGQ6QlO4YBpv3c2q8SfPxHqftIyLB9vxwFAbfZKE
         R9gqaS9JAMNbQ9vM/XQuBSKjcs8/JTDH9xTMnu0sYd0iGLbu6E2SgcXzR36/MIqSTnJR
         ae9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777979581; x=1778584381;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=dzDOKNU0TaHsfyv5XbUdLHd2w3+qHipKrsIES1vuEME=;
        b=QfaPhtvND2HCjc55inF4DlRLKaTb+NnCX9BxnXgdK2Re4/3EUefrN7z1IVLky/eIY6
         vlVLPhWzYpJnOwGgokWglLYSoa40QWHlohVLQt1mjq6SUEk6T60TdoMgyQmX7ybNiCAM
         OpYt3GyQCawj6izPg2U8gWUPL80UlJasq4miyiYpFrKaYbUeb+cQL7S2EPP545qohtrM
         U1lFsgROq67eRr3YIm7BjMAmwpb2ITEFAD7azsYSBE8G4R/MC+rTx/ar4YDwcV7dkNFg
         cfWk5fCUVRZt1RQID/MKzeBdKRVUzV2maF54UlkGqPPuVsWuEjYNLzhxPgqmjUhNq+An
         Ohig==
X-Gm-Message-State: AOJu0YyYc+830a/L8ZPwleq0wqG66rfJVkmW9aSO0NTZF7SqBV9sTSY+
	K/RYk7lZ6KhtJF4eTAbhUrG5/h6RiugStO8qdSGYSUY1QIa1t36E+qYWbTyJ
X-Gm-Gg: AeBDietvuUIrcSfgPYMESWDoXMRZ3NdhdZvzcEA2CBOqkXTSUUnVHvfOyJ25H+zmE0I
	0XcF1I4F6hbtVD+tJORzpZOQ0wnLwMVvOZEhDtUNmUI6HRCy3m6NVnOTz6GwSiORqOwNW5gy8zw
	CDjtHpu86n6fHrm/3jt5row1OSNU7xOXCh0DWR4jZ+YSJv7diqiXvceIJg8FrnHO1nG7vzi1NdQ
	pXXymDxA1daUEzfMULhu5tBeBI4T7GLgk3Rq6QUj6n3QZIAwgrzckWwQ9B28esYzzkv783uMiWF
	KQzC12MiVcrcpWC7ywsdvMEl0X2zmEKNA2Ypl8qMNb8MS9iN4b2PRxHJFdg2e3t8Mx0XsVukmeR
	vP2M/xorgcFj+FsIBdz3Y5SFb7rZHmApe/g65UX9ixnQcRCa3dCV0TCiox/imnmra2YOAhUjbC5
	ZcYeI=
X-Received: by 2002:a05:600c:a46:b0:48a:563c:c8e0 with SMTP id 5b1f17b1804b1-48d186dca76mr41800975e9.1.1777979581412;
        Tue, 05 May 2026 04:13:01 -0700 (PDT)
Received: from debian.. ([2001:41d0:303:db6b::])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45052a488d8sm3786183f8f.12.2026.05.05.04.13.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 May 2026 04:13:00 -0700 (PDT)
From: Tristan Madani <tristmd@gmail.com>
To: Viacheslav Dubeyko <slava@dubeyko.com>
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/2] hfs/hfsplus: fix OOB access and uninit-value in bnode operations
Date: Tue,  5 May 2026 11:12:57 +0000
Message-ID: <20260505111300.3592757-1-tristmd@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260501110218.29906-1-tristmd@gmail.com>
References: <20260501110218.29906-1-tristmd@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Tristan Madani <tristan@talencesecurity.com>

Two fixes for long-standing syzbot reports in the HFS/HFS+ B-tree node
handling code.

Changes since v1 (20260501110218.29906-{1..3}-tristmd@gmail.com):
 - Patch 1: use (u64) widening cast per Dubeyko's feedback
 - Patch 2: memset inside hfs_bnode_read() covering all callers in both
   fs/hfs/ and fs/hfsplus/, per Dubeyko's feedback
 - Dropped patch 3 (NULL deref in hfsplus_create_attributes_file):
   already fixed by Dubeyko's patch [1]

[1] https://lore.kernel.org/linux-fsdevel/6601b6ec0de087674f60566db950449c4e821bfc.camel@redhat.com/

Tristan Madani (2):
  hfs/hfsplus: fix u32 overflow in check_and_correct_requested_length
  hfs/hfsplus: zero-initialize buffer in hfs_bnode_read

 fs/hfs/bnode.c          | 4 +++-
 fs/hfsplus/bnode.c      | 2 ++
 fs/hfsplus/hfsplus_fs.h | 2 +-
 3 files changed, 6 insertions(+), 2 deletions(-)

-- 
2.47.3
