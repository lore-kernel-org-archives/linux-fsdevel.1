Received: from mail-lf2-f12.google.com (mail-lf2-f12.google.com [74.125.229.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5B683CE4B5
	for <linux-fsdevel@vger.kernel.org>; Mon, 28 Sep 2026 18:59:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.229.204
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790621954; cv=pass; b=q/3158DFjq2fkLgcbnsnvC0rJj2/4jjy87839gdb8W3u91qEOagwelgK6oi8QXMuB7ZcL8QoEhBB1z7u2Up9EvxjZslYK+dTC65dRZMCiQG5CKvVIKfxOJpA90sQOiHycL+6tyGivqSY2BxmWabAsccGiuZgrOrWFqbehspzV7c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790621954; c=relaxed/simple;
	bh=zbxh97DfahtmVFw2yx/P+OI0PpzLVE463PD6gyDR+VQ=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=SkYtdhGngOORO0yPDF65OWDdLpoAxCndnBNV6POZmKO0kQKuVTzZ6z0rQt5Z90lBd3A8TPTjntIEHEVZ/Y41eZJ4hYSAWJ4z9k87YRWNSxrG7ts4nn5Po3g7tjJ6zoHB50DjJYt/UY9TZmKC7DmWhfnoQW+r7d2IOe9uBI3VwCw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ALNlkfXN; arc=pass smtp.client-ip=74.125.229.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ALNlkfXN"
Received: by mail-lf2-f12.google.com with SMTP id 2adb3069b0e04-5b8f35f74caso1703290e87.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 28 Sep 2026 11:59:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790621950; cv=none;
        d=google.com; s=arc-20260327;
        b=BmCTbUAOvlgA8aT+Z94RufATNPiL4M30vJyDj8TeX6LmDcYVR1mEn4mzT36aD4C5fA
         ZcIJjp4w8PWFZbrLOjbCcTyz4C5sg8WJnhnwGJVQrien2upPO6tYFMBHOoRD7oGIn3rd
         i6o+he25d2Rh2xat2E51jIRbr4yI21TzTiJKOVwkAXDzYOxzoAN3MbKCciN20r2kaUob
         2bYiHWWlIs1kaI7GJ/yBf5wy9MpTfB+N9rtRvKtIs4MWx4Iaj69NyeHIeTqT0/XkRHrX
         0eMughY8GBZKMiOM2gqXnXr/ZGlCZ1NdOZ3dZvL/NoX0cq73RlBzEwgJZ6akAAWb0dsE
         m99A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:sender:mime-version
         :dkim-signature;
        bh=2mj3lyrm7aE/R7y/QOz0OagCVKj44YeS0Sz+Yo0D/po=;
        fh=p0l7L6X+X8bd1tkIAbrP210B8ITAXRlx9/SGiWL0ui8=;
        b=VLbGepA6RVoCfIrq5Yx/fosFOACRpG47f4KwJPUzLDX858qa0hrai7g5HSR80maQ5+
         oWhUFtLQpGsDsZ7aDGX2HdZ1zUEIN6hkr/qtxXuLZkseV9OCGgh3SHNH6GmXd6th3fki
         wMWm5MfjtS659cr/Bkj5eY696uyy8p6b10XtGdZVC1TIERTbCzMR8vCITqBavCXjLXlH
         wIGOgZknybUepHym+wPwicRyrNuSYrXAjuAIsMyhCGS88vDZSaaMdRsZHP3PG1kiEobU
         BcqY/pb2RPAh5BEqjgjtuG6i+gxU6yHvqnM0EXKFN/mrJS8NrpwFx/6IoyeaqhT/OmEt
         wa1g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790621950; x=1791226750; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:sender:mime-version
         :from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=2mj3lyrm7aE/R7y/QOz0OagCVKj44YeS0Sz+Yo0D/po=;
        b=ALNlkfXNuHGvk48OfekmkexPjAHnoMbcsmSB3p+GYTqQ/2wliYgKPKzGrseWFJNf6a
         5qOYy+y/brxPI6LgihssK3ElXOsT+OCYvaWcIgETehpKUIX/SFwoaXpkwcRNUIGDeySX
         +1p9YXd0w7CLVCkYd2X+RVRUwm11tnWty/dnVv9uzJtFBBr7Ulin5dikMzZwJDnKzFqi
         A8dbUJl7jQzgVOovGH2WaXL3ClgPnPimSBmDQjwv6/ECl45EfrEU6LPzPm+f8I1s+0ft
         qXJWynVqFiJbAf6aBJX/oDRl20hV58+2IYhqihGcGvbVWIzAmyJzrRLVq1fKvz1jAPUc
         DlqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790621950; x=1791226750;
        h=content-type:cc:to:subject:message-id:date:from:sender:mime-version
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=2mj3lyrm7aE/R7y/QOz0OagCVKj44YeS0Sz+Yo0D/po=;
        b=GT0zYaP+Zqj/qIk2DFTf3wndG1DzJmYIyAUgBrKJQ6oofQ17NRocX+yx1lq28QcRux
         5YbzG9J3bktCu1x7/o/xRhjALm9VVBx+YhjBWa+pfvqCn29HbKTC/mHFptnTudqD4BEP
         NATRv09BLWtaeEvagHV2T5rDhy6j6Aed5l8aIQDB2Qtp/MVMEqulv5hu2H86qkeVC3AW
         uVfS3VniT3HFI1ld1p8y2yf6nAKt7RwzlKBu1jZ+Qnt3myNaPMZwI/Si1LsU3bYpG/cP
         gmgV9J7BXmedPRcrmlkHddNaYR5WOEQnmom9ACc/FLXwSI2pdzCwsiEBf1PssRimmOC5
         I71A==
X-Gm-Message-State: AFq9FYK/lQUBiDSXhVduNPJyBJ7NHW/627Pb06LOK7PBYl8SraUU+9Xs
	Gvsk6uVF/ICUiV1yJyxG26vlkuZM6Qk+ifR+aZgERNRobiI1zE2Qnm767NWq+eorAuXo87/VMeu
	u/3WyX7pQXWk18wMz0ClMrf8hz8KP9NR8Z+AA
X-Gm-Gg: AYBFou0CSuZZOZCiIgR79wdVId/wDZWgewJ1B48KLOFzXy4dOkaxAcuQFIbSC3U8jIR
	e/a8lCcROdRZYBjBVPaQVfDycyxkwpO3lATV2sY3ZzpOKyp6bfV0gwOb+XgIwbFyiUhG2/xVSbC
	nkuPq12+v/yCDBqUXsUIZaF45d7LaHf5JnXrpfiOafNzEW1bv+kupLfEW1JaIrO3LLHf5U6MyjZ
	gcaCiwhhG8W7T98H//NvjA++DyyFFkyPKwI8bWbylKP8P245ysWq+zHc1Y2lxw1fe/Q7ABA908A
	sRKe1c+6seA1C5b5/GJQQsJd1+3iurmYnUNpcp+z8IrF/oj2RxfTkKZb6x4qXhRoKECjV6J5f9E
	o2QnXziF6bo6t
X-Received: by 2002:a05:6512:230f:b0:5b8:f30f:7cfe with SMTP id
 2adb3069b0e04-5b8f30f7de0mr2381443e87.36.1790621949786; Mon, 28 Sep 2026
 11:59:09 -0700 (PDT)
Received: from 254448290189 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 28 Sep 2026 11:59:08 -0700
Received: from 254448290189 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 28 Sep 2026 11:59:08 -0700
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Sender: Vamsi Krishna Kattamuri <kattamurivamsikrishna17@gmail.com>
From: Vamsi Krishna Kattamuri <kattamurivamsikrishna17@gmail.com>
Date: Mon, 28 Sep 2026 11:59:08 -0700
X-Google-Sender-Auth: yJdVTHyK8StYuaczuakEtPmSH0s
X-Gm-Features: AclHuK-Xz52AgVCzLAZuF5oizm1zR161dvYMBuInRdqEcsrUcYBfED0bFxZLpG4
Message-ID: <CAANnmVB6Wu+vtdmg+S5uZKkdYMA1gOSQBQ25SpSpasKG9U-1-g@mail.gmail.com>
Subject: [PATCH] fs/adfs: check name length of big directory entries
To: linux-fsdevel@vger.kernel.org
Cc: brauner@kernel.org, rmk+kernel@armlinux.org.uk, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

The F+ (big directory) entry format stores the object name length on
disc as a 32-bit value, bigdirobnamelen.  adfs_fplus_getnext() stores
this value in struct object_info::name_len and then copies that many
bytes from the directory buffers into the fixed-size obj->name array
with adfs_dir_copyfrom(), which only validates the source range, not
the destination.

Nothing validates bigdirobnamelen, so a corrupt or maliciously
crafted filesystem image can specify a name length greater than
sizeof(obj->name), causing up to 4MB of attacker-controlled data to
be written past the end of the array.  Both callers of ->getnext()
instantiate struct object_info on their stacks - adfs_fplus_iterate()
via readdir() and adfs_lookup() via path resolution - so this is a
stack buffer overflow which is trivially triggered by listing or
stat'ing files on a crafted image.

adfs_object_fixup() also appends a four character ",xxx" filetype
suffix to the names of non-directory objects when the ftsuffix mount
option is enabled, so name lengths greater than ADFS_FPLUS_NAME_LEN
could still overflow the buffer by up to four bytes even when the
initial copy itself fits.

Reject entries whose name length exceeds the maximum defined for the
F+ format, which also leaves room for the filetype suffix.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Cc: stable@vger.kernel.org
Signed-off-by: Vamsi Krishna Kattamuri <kattamurivamsikrishna17@gmail.com>
---
 fs/adfs/dir_fplus.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/fs/adfs/dir_fplus.c b/fs/adfs/dir_fplus.c
index 4a15924014da..ec663bc12a92 100644
--- a/fs/adfs/dir_fplus.c
+++ b/fs/adfs/dir_fplus.c
@@ -192,6 +192,11 @@ adfs_fplus_getnext(struct adfs_dir *dir, struct
object_info *obj)
 	obj->indaddr  = le32_to_cpu(bde.bigdirindaddr);
 	obj->attr     = le32_to_cpu(bde.bigdirattr);
 	obj->name_len = le32_to_cpu(bde.bigdirobnamelen);
+	if (obj->name_len > ADFS_FPLUS_NAME_LEN) {
+		adfs_error(dir->sb, "object name length %u exceeds maximum",
+			   obj->name_len);
+		return -ENAMETOOLONG;
+	}

 	offset = adfs_fplus_offset(h, le32_to_cpu(h->bigdirentries));
 	offset += le32_to_cpu(bde.bigdirobnameptr);
-- 
2.47.3
