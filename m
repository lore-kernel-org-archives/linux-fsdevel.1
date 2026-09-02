Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCAFE4A2A79;
	Wed,  2 Sep 2026 13:28:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788355705; cv=none; b=BePugPjh6kTQxwyOqy8UE4BmXq9z8A2d5HWME1KwWfgVA0FyTcCAFdSjPOAC/nvfISkcgdei2Jn54qlMo2s6zmPrpzNNQhvmsGi+mELQVopZJs1n2SxQOrZML0OImlSkUSZ4UXUdluFNjd2jzWn4a4dlcbBMawQY34Vt9vwlA3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788355705; c=relaxed/simple;
	bh=9B4p2CL9qctopDIxo+KXlNZsHJI+dVZmzPAUpOedsMA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Elr9MvNTV7ovV+ScQ/dNGhMujCJaNra1W1hSFMnOcgEYwmPmODJWTbOpm+lLQRiLlQwoCyLnIDFNNVFsnnkQvsFe1zXfCQfzfTBpa/U+Qfhru4U1aBJekaxLG/1wuFBtkbuQMZj+SSrwgBS4ahWBLu0k6Pt6oOeqfIFW3wMk9lQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OdHOrsfn; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OdHOrsfn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 168B31F000E9;
	Wed,  2 Sep 2026 13:28:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788355703;
	bh=geBhGzf9cUnk3yzaHjFsAOOWlmrxzTwK75Z/iOmcQgA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=OdHOrsfnpLKRwrNRRHiRk90GY8/Q3wL1/wflXxZVpvaAM6Hm9CvoKx8HPLNiRyzPP
	 xFx7ULxE8b7uJVlcBi/1EZ81OOfCTA+UqUKocZhmJ/ELEGQlDIbyJAIpPPn1uHW1S6
	 fKa9rB1h8oYtP1fW5xSMrjF/A7lmVp8PHG2ks/v4DZZ8HTCnRf51lOC/rN75tevE23
	 t4Ji4k96NdJ4oeZQQiPu8NKYUYmf8vUu3oPmOqhaENd5daDHQrbiZ6Jjym89mZdiWo
	 PBumOsJthuIobny1/oJZdWoK4UWyfjewkehCd2wPuM9vevmmx/IOldCZINdUySKK66
	 f1UxjVQp6z1bg==
From: Andreas Hindborg <a.hindborg@kernel.org>
Date: Wed, 02 Sep 2026 15:25:58 +0200
Subject: [PATCH v5 02/12] rust: xarray: add debug format for `StoreError`
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260902-xarray-entry-send-v5-2-d18adae40708@kernel.org>
References: <20260902-xarray-entry-send-v5-0-d18adae40708@kernel.org>
In-Reply-To: <20260902-xarray-entry-send-v5-0-d18adae40708@kernel.org>
To: Tamir Duberstein <tamird@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, 
 Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
 Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, 
 Daniel Almeida <daniel.almeida@collabora.com>, 
 Alexandre Courbot <acourbot@nvidia.com>, 
 =?utf-8?q?Onur_=C3=96zkan?= <work@onurozkan.dev>, 
 Matthew Wilcox <willy@infradead.org>, 
 Andrew Morton <akpm@linux-foundation.org>, Lorenzo Stoakes <ljs@kernel.org>, 
 "Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, 
 Harry Yoo <harry@kernel.org>, Hao Li <hao.li@linux.dev>, 
 Christoph Lameter <cl@gentwo.org>, David Rientjes <rientjes@google.com>, 
 Roman Gushchin <roman.gushchin@linux.dev>
Cc: Andreas Hindborg <a.hindborg@kernel.org>, 
 rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, 
 Daniel Gomez <da.gomez@samsung.com>, Tamir Duberstein <tamird@kernel.org>, 
 "Liam R. Howlett" <liam@infradead.org>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1348; i=a.hindborg@kernel.org;
 h=from:subject:message-id; bh=9B4p2CL9qctopDIxo+KXlNZsHJI+dVZmzPAUpOedsMA=;
 b=owEBbQKS/ZANAwAKAfpQKQiqxb3QAcsmYgBqmCQaCGpAFW6/BSWw+xrp731q7NFnlJ0hRz0Gh
 uySzsBhGKeJAjMEAAEKAB0WIQRXitnI2WZ2JirAaob6UCkIqsW90AUCapgkGgAKCRD6UCkIqsW9
 0Jq9EACwI4S5rCSSyPKySNKDNJdjwO/Du5ue1uvV7K+mHum1BdqTjcpM9OJd9L1enaG52oAnr4b
 me3nVmab/3UMApxgHkQ7X34jM2Fd7PBu7EFCD+hgfplYwC4v9Vqc/FnU6b19ecj/tgh/Nzv7k75
 ON/4yE1cVBLgt3rCu8yD+2A0MkbAGEqb8/3/MYz1KVOwXwjcWV3nAiXxEDYbmUUqZh/Uaivl0BG
 h+kgD8VSKUAtJNV9tjVHpvgQ8nU0u1MprjrpvtQeOhPUXd7eYnFEp5YG2gAabRCW9KJbJ0feLiu
 6TLohZTDaUYjwdZP+qsxX9P+xxilpfiQeSuSch+Az9ZnTWJH5Bybuk67Kp70EK0SeAfuA93sDXn
 OqPqirC8XkzdLX3J2ebc+di2QN9JkeGr4aWQAXdV8Om4wJ1+jTHa3Hk1qjDsw9/FzIdiqjMJMtv
 iDq8kyIrN/ACCUTu1ZPcMuCIiGSGFQ5BcOdpQkcSWg3uMsViX7CA2yF5hfJ3/qNMeunGMaDvLVb
 MfjAW2PKwLz2lsY/yFdhzN2bteOhXq8F9uWr0OR1EYDN9oudTJ8TtnPFeF0TSXb3oZioYZvHCZn
 4YONbdXaN4DizDc6Qw6GZwVZHH1WPXsCVOqXyyGacyEZzp0Bc63Jez4DFSi5Qo+Hf4R0UxVm/VF
 EH2M9JViuxyJAMA==
X-Developer-Key: i=a.hindborg@kernel.org; a=openpgp;
 fpr=3108C10F46872E248D1FB221376EB100563EF7A7

Add a `Debug` implementation for `StoreError<T>` to enable better error
reporting and debugging. The implementation only displays the `error`
field and omits the `value` field, as `T` may not implement `Debug`.

Reviewed-by: Gary Guo <gary@garyguo.net>
Reviewed-by: Daniel Gomez <da.gomez@samsung.com>
Acked-by: Tamir Duberstein <tamird@gmail.com>
Acked-by: Liam R. Howlett <Liam.Howlett@oracle.com>
Reviewed-by: Daniel Almeida <daniel.almeida@collabora.com>
Assisted-by: LLM
Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>
---
 rust/kernel/xarray.rs | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/rust/kernel/xarray.rs b/rust/kernel/xarray.rs
index 02f93ae1f92d..4335caab8cca 100644
--- a/rust/kernel/xarray.rs
+++ b/rust/kernel/xarray.rs
@@ -19,6 +19,7 @@
         Result, //
     },
     ffi::c_void,
+    fmt,
     types::{
         ForeignOwnable,
         NotThreadSafe,
@@ -193,6 +194,14 @@ pub struct StoreError<T> {
     pub value: T,
 }
 
+impl<T> fmt::Debug for StoreError<T> {
+    fn fmt(&self, f: &mut fmt::Formatter<'_>) -> fmt::Result {
+        f.debug_struct("StoreError")
+            .field("error", &self.error)
+            .finish()
+    }
+}
+
 impl<T> From<StoreError<T>> for Error {
     #[inline]
     fn from(value: StoreError<T>) -> Self {

-- 
2.51.2


